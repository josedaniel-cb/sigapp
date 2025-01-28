import 'package:shared_preferences/shared_preferences.dart';

class CookieManager {
  final SharedPreferences _prefs;
  final String _id;

  CookieManager({
    required String id,
    required SharedPreferences prefs,
  })  : _prefs = prefs,
        _id = id;

  String _buildKey(String host) {
    return '${_id}_cookies_$host';
  }

  Future<void> saveCookies(String host, List<String> newCookies) async {
    final key = _buildKey(host);
    var existingCookies = _prefs.getStringList(key) ?? [];

    // Create a map to track the latest cookie value by name
    final Map<String, String> cookiesMap = {};

    // Add existing cookies to the map
    for (var cookie in existingCookies) {
      final parts = cookie.split('=');
      if (parts.length >= 2) {
        cookiesMap[parts[0]] = parts.sublist(1).join('=');
      }
    }

    // Update the map with new cookies, replacing values for existing names
    for (var cookie in newCookies) {
      final parts = cookie.split('=');
      if (parts.length >= 2) {
        cookiesMap[parts[0]] = parts.sublist(1).join('=');
      }
    }

    // Convert the map back to a list of cookies
    final uniqueCookies =
        cookiesMap.entries.map((e) => "${e.key}=${e.value}").toList();

    // Save the updated list back to SharedPreferences
    await _prefs.setStringList(key, uniqueCookies);
  }

  List<String> getCookies(String host) {
    removeExpiredCookies(host);

    final key = _buildKey(host);
    final cookies = _prefs.getStringList(key) ?? [];
    return cookies;
  }

  void clearCookies(String host) {
    final key = _buildKey(host);
    _prefs.remove(key);
  }

  bool hasCookie(String host, String cookieKey) {
    final cookies = getCookies(host);
    return cookies.any((cookie) => cookie.contains(cookieKey));
  }

  Future<void> removeExpiredCookies(String host) async {
    final key = _buildKey(host);
    var cookies = _prefs.getStringList(key) ?? [];

    cookies.removeWhere((cookie) {
      final parts = cookie.split(';').map((e) => e.trim()).toList();
      for (var part in parts) {
        if (part.toLowerCase().startsWith('expires=')) {
          final expiresValue = part.substring('expires='.length);
          final expiresDate = DateTime.tryParse(expiresValue);
          if (expiresDate != null && expiresDate.isBefore(DateTime.now())) {
            return true;
          }
        }
      }
      return false;
    });

    await _prefs.setStringList(key, cookies);
  }
}
