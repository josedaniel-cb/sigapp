import 'dart:async';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Manages secure storage and retrieval of auth tokens
class TokenManager {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static const String _accessTokenKey = 'supabase_access_token';
  static const String _refreshTokenKey = 'supabase_refresh_token';

  Future<void> setAccessToken(String token) async {
    await _secureStorage.write(key: _accessTokenKey, value: token);
  }

  Future<void> setRefreshToken(String token) async {
    await _secureStorage.write(key: _refreshTokenKey, value: token);
  }

  Future<void> clearTokens() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }
}

/// Handles token refresh operations with concurrency protection
class TokenRefreshManager {
  final TokenManager _tokenManager;
  final String _baseUrl;

  // Refresh token lock mechanism
  bool _isRefreshing = false;
  final List<Function(bool)> _refreshCallbacks = [];

  // Queue to track pending requests during token refresh
  final List<_QueuedRequest> _requestQueue = [];

  TokenRefreshManager(this._tokenManager, this._baseUrl);

  /// Handle a token refresh based on a failed request
  Future<Response?> handleTokenRefresh(RequestOptions failedRequest) async {
    // Queue this request
    final completer = Completer<Response?>();
    final queuedRequest = _QueuedRequest(failedRequest, completer);
    _requestQueue.add(queuedRequest);

    // Try token refresh with lock mechanism
    final success = await _refreshTokenWithLock();

    if (success) {
      try {
        return await completer.future;
      } catch (e) {
        developer.log(
          'Queued request failed after token refresh: $e',
          name: 'TokenRefreshManager',
        );
        return null;
      }
    } else {
      // Clean up the queued request since refresh failed
      _requestQueue.removeWhere(
        (request) => request == queuedRequest,
      );
      return null;
    }
  }

  /// Refreshes token with a lock mechanism to prevent multiple simultaneous refreshes
  Future<bool> _refreshTokenWithLock() async {
    // If already refreshing, wait for that refresh to complete
    if (_isRefreshing) {
      developer.log(
        'Token refresh already in progress, waiting...',
        name: 'TokenRefreshManager',
      );

      // Use completer to wait for the refresh result
      final completer = Completer<bool>();
      _refreshCallbacks.add((success) => completer.complete(success));
      return completer.future;
    }

    // Set refreshing flag to true
    _isRefreshing = true;

    try {
      // Do the actual refresh
      final success = await _refreshToken();

      // Process queued requests if refresh was successful
      if (success) {
        await _processQueue();
      }

      // Notify all waiting callbacks
      _notifyRefreshCallbacks(success);

      return success;
    } finally {
      // Reset the refreshing flag
      _isRefreshing = false;
    }
  }

  /// Actual token refresh implementation
  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await _tokenManager.getRefreshToken();
      if (refreshToken == null) {
        developer.log(
          'Cannot refresh token: No refresh token available',
          name: 'TokenRefreshManager',
        );
        return false;
      }

      final uri = Uri.parse('$_baseUrl/auth/v1/token?grant_type=refresh_token');
      final headers = {'Content-Type': 'application/json'};
      final body = {'refresh_token': refreshToken};

      final tempDio = Dio();
      final response = await tempDio.post(
        uri.toString(),
        options: Options(headers: headers),
        data: body,
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final data = response.data;
        final newAccessToken = data['access_token'];
        final newRefreshToken = data['refresh_token'];

        developer.log(
          'Token refresh successful',
          name: 'TokenRefreshManager',
        );

        if (newAccessToken != null) {
          await _tokenManager.setAccessToken(newAccessToken);
          if (newRefreshToken != null) {
            await _tokenManager.setRefreshToken(newRefreshToken);
          }
          return true;
        }
      } else {
        developer.log(
          'Token refresh failed: ${response.statusCode} - ${response.data}',
          name: 'TokenRefreshManager',
        );
      }
      return false;
    } catch (e, s) {
      developer.log(
        'Error refreshing token',
        name: 'TokenRefreshManager',
        error: e,
        stackTrace: s,
      );
      return false;
    }
  }

  /// Process all queued requests with the new token
  Future<void> _processQueue() async {
    developer.log(
      'Processing queue with ${_requestQueue.length} requests',
      name: 'TokenRefreshManager',
    );

    // Create a copy to avoid concurrent modification issues
    final requests = List<_QueuedRequest>.from(_requestQueue);
    _requestQueue.clear();

    for (var request in requests) {
      try {
        // Get fresh token for each request
        final accessToken = await _tokenManager.getAccessToken();
        final opts = request.options;
        opts.headers['Authorization'] = 'Bearer $accessToken';

        // Mark as retry to avoid loops
        opts.extra['isRetry'] = true;

        // Create new request with the updated token
        final dio = Dio();
        final response = await dio.fetch(opts);
        request.completer.complete(response);
      } catch (e) {
        developer.log(
          'Failed to process queued request: $e',
          name: 'TokenRefreshManager',
        );
        request.completer.completeError(e);
      }
    }
  }

  /// Notify all callbacks waiting for refresh completion
  void _notifyRefreshCallbacks(bool success) {
    for (var callback in _refreshCallbacks) {
      callback(success);
    }
    _refreshCallbacks.clear();
  }
}

/// Class to represent a queued request waiting for token refresh
class _QueuedRequest {
  final RequestOptions options;
  final Completer<Response?> completer;

  _QueuedRequest(this.options, this.completer);
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
}
