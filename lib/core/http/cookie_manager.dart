// import 'dart:io';

// import 'package:shared_preferences/shared_preferences.dart';

// class CookieManager {
//   final SharedPreferences _prefs;
//   final String _id;

//   CookieManager({
//     required String id,
//     required SharedPreferences prefs,
//   })  : _prefs = prefs,
//         _id = id;

//   String _buildKey(String host) {
//     return '${_id}_cookies_$host';
//   }

//   Future<void> saveCookies(String host, List<String> newCookies) async {
//     final key = _buildKey(host);
//     var existingCookies = _prefs.getStringList(key) ?? [];

//     // Create a map to track the latest cookie value by name
//     final Map<String, String> cookiesMap = {};

//     // Add existing cookies to the map
//     for (var cookie in existingCookies) {
//       final parts = cookie.split('=');
//       if (parts.length >= 2) {
//         cookiesMap[parts[0]] = parts.sublist(1).join('=');
//       }
//     }

//     // Update the map with new cookies, replacing values for existing names
//     for (var cookie in newCookies) {
//       final parts = cookie.split('=');
//       if (parts.length >= 2) {
//         cookiesMap[parts[0]] = parts.sublist(1).join('=');
//       }
//     }

//     // Convert the map back to a list of cookies
//     final uniqueCookies =
//         cookiesMap.entries.map((e) => "${e.key}=${e.value}").toList();

//     // Save the updated list back to SharedPreferences
//     await _prefs.setStringList(key, uniqueCookies);
//   }

//   List<String> getCookies(String host) {
//     removeExpiredCookies(host);

//     final key = _buildKey(host);
//     final cookies = _prefs.getStringList(key) ?? [];
//     return cookies;
//   }

//   void clearCookies(String host) {
//     final key = _buildKey(host);
//     _prefs.remove(key);
//   }

//   bool hasCookie(String host, String cookieKey) {
//     final cookies = getCookies(host);
//     return cookies.any((cookie) => cookie.contains(cookieKey));
//   }

//   Future<void> removeExpiredCookies(String host) async {
//     final key = _buildKey(host);
//     var cookies = _prefs.getStringList(key) ?? [];

//     cookies.removeWhere((cookie) {
//       final parts = cookie.split(';').map((e) => e.trim()).toList();
//       for (var part in parts) {
//         if (part.toLowerCase().startsWith('expires=')) {
//           final expiresValue = part.substring('expires='.length);
//           final expiresDate = DateTime.tryParse(expiresValue);
//           if (expiresDate != null && expiresDate.isBefore(DateTime.now())) {
//             return true;
//           }
//         }
//       }
//       return false;
//     });

//     await _prefs.setStringList(key, cookies);
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Class that replicates the fields of a Cookie and allows serialization to JSON.
class SerializableCookie {
  String name;
  String value;
  DateTime? expires;
  int? maxAge;
  String? domain;
  String? path;
  bool secure;
  bool httpOnly;
  SameSite? sameSite;

  SerializableCookie({
    required this.name,
    required this.value,
    this.expires,
    this.maxAge,
    this.domain,
    this.path,
    this.secure = false,
    this.httpOnly = false,
    this.sameSite,
  });

  /// Build a [SerializableCookie] from a [Cookie] of `dart:io`.
  factory SerializableCookie.fromCookie(Cookie cookie) {
    return SerializableCookie(
      name: cookie.name,
      value: cookie.value,
      expires: cookie.expires,
      maxAge: cookie.maxAge,
      domain: cookie.domain,
      path: cookie.path,
      secure: cookie.secure,
      httpOnly: cookie.httpOnly,
      sameSite: cookie.sameSite,
    );
  }

  /// Parse a [SerializableCookie] to a [Cookie] of `dart:io`.
  Cookie toCookie() {
    final c = Cookie(name, value);
    c.expires = expires;
    c.maxAge = maxAge;
    c.domain = domain;
    c.path = path;
    c.secure = secure;
    c.httpOnly = httpOnly;
    c.sameSite = sameSite;
    return c;
  }

  /// Serialize the object to a Map<String, dynamic>.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'expires': expires?.toUtc().toIso8601String(), // Guardar UTC en ISO
      'maxAge': maxAge,
      'domain': domain,
      'path': path,
      'secure': secure,
      'httpOnly': httpOnly,
      'sameSite': sameSite?.name, // Usar el nombre de SameSite
    };
  }

  /// Rebuild the object from a Map<String, dynamic>.
  factory SerializableCookie.fromJson(Map<String, dynamic> json) {
    return SerializableCookie(
      name: json['name'] as String,
      value: json['value'] as String,
      expires: json['expires'] != null
          ? DateTime.tryParse(json['expires'] as String)?.toLocal()
          : null,
      maxAge: json['maxAge'] as int?,
      domain: json['domain'] as String?,
      path: json['path'] as String?,
      secure: json['secure'] as bool? ?? false,
      httpOnly: json['httpOnly'] as bool? ?? false,
      sameSite: json['sameSite'] != null
          ? SameSite.values.firstWhere((e) => e.name == json['sameSite'])
          : null,
    );
  }
}

class CookieManager {
  final SharedPreferences _prefs;
  final String _id;

  CookieManager({
    required String id,
    required SharedPreferences prefs,
  })  : _prefs = prefs,
        _id = id;

  /// Returns the key used in SharedPreferences for a specific host.
  String _buildKey(String host) => '${_id}_cookies_$host';

  /// Saves (or updates) cookies based on the 'Set-Cookie' headers received.
  ///
  /// - `host`: domain/host where the cookies come from.
  /// - `setCookieHeaders`: list of 'Set-Cookie' strings.
  Future<void> saveCookies(String host, List<String> setCookieHeaders) async {
    // 1. Parses strings into Cookie objects
    final newCookies = setCookieHeaders
        .map((header) => Cookie.fromSetCookieValue(header))
        .toList();

    // 2. Load existing cookies for the host
    final existing = _loadCookies(host);

    // 3. Merge: for each new cookie, find if there is an equal one
    //    (same name, domain, path). If so, replace it.
    for (final c in newCookies) {
      _mergeCookie(existing, c);
    }

    // 4. Save the unified list in SharedPreferences.
    await _saveCookies(host, existing);
  }

  /// Returns the list of valid (non-expired) cookies for the [host].
  List<Cookie> getCookies(String host) {
    final cookies = _loadCookies(host);

    // Remove expired cookies
    final now = DateTime.now();
    cookies.removeWhere((c) => _isExpired(c, now));

    return cookies;
  }

  /// Deletes all cookies associated with a host.
  Future<void> clearCookies(String host) async {
    final key = _buildKey(host);
    await _prefs.remove(key);
  }

  /// Verifies if there is a cookie whose name matches [cookieName] (for a given host).
  bool hasCookie(String host, String cookieName) {
    final cookies = getCookies(host);
    return cookies.any((c) => c.name == cookieName);
  }

  /// Internal method to merge a cookie into the list (replaces if name/domain/path match).
  void _mergeCookie(List<Cookie> cookies, Cookie newCookie) {
    for (int i = 0; i < cookies.length; i++) {
      final c = cookies[i];
      if (c.name == newCookie.name &&
          c.domain == newCookie.domain &&
          c.path == newCookie.path) {
        // Remove the old cookie and insert the new one in its place
        cookies[i] = newCookie;
        return;
      }
    }
    // If no match was found, we add the new cookie
    cookies.add(newCookie);
  }

  /// Loads cookies from SharedPreferences and converts them to `Cookie` (if there is something saved).
  List<Cookie> _loadCookies(String host) {
    final key = _buildKey(host);
    final raw = _prefs.getString(key);
    if (raw == null) return [];

    try {
      final List<dynamic> jsonList = jsonDecode(raw);
      return jsonList.map((e) {
        final sc = SerializableCookie.fromJson(e as Map<String, dynamic>);
        return sc.toCookie();
      }).toList();
    } catch (e) {
      // If there is a parsing error, return an empty list
      if (kDebugMode) {
        print("Error parseando cookies de SharedPrefs: $e");
      }
      return [];
    }
  }

  /// Saves the list of cookies in SharedPreferences (JSON serialization).
  Future<void> _saveCookies(String host, List<Cookie> cookies) async {
    // First, remove expired cookies
    final now = DateTime.now();
    cookies.removeWhere((c) => _isExpired(c, now));

    // Convert to SerializableCookie and then to JSON
    final serializableList =
        cookies.map((c) => SerializableCookie.fromCookie(c).toJson()).toList();
    final jsonString = jsonEncode(serializableList);

    await _prefs.setString(_buildKey(host), jsonString);
  }

  /// Determines if a cookie has expired given its `expires` or `maxAge` properties.
  bool _isExpired(Cookie cookie, DateTime now) {
    // maxAge=0 or negativo => expired
    if (cookie.maxAge != null) {
      if (cookie.maxAge! <= 0) return true;
      // If maxAge is positive, we don't know if it has expired yet.
    }
    if (cookie.expires != null) {
      return cookie.expires!.isBefore(now);
    }
    // If it has neither expires nor maxAge, we treat it as a "Session Cookie"
    // that generally remains until the app is closed. We don't expire it here.
    return false;
  }
}
