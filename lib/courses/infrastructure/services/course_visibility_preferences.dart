import 'package:shared_preferences/shared_preferences.dart';

class CourseVisibilityPreferences {
  static const String _keyPrefix = 'course_visibility_';

  // Obtiene el estado de visibilidad de un curso
  static Future<bool> isEventHidden(String eventId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$_keyPrefix$eventId') ?? false;
  }

  // Guarda el estado de visibilidad de un curso
  static Future<void> setEventHidden(String eventId, bool isHidden) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_keyPrefix$eventId', isHidden);
  }

  // Obtiene una lista de todos los eventos ocultos
  static Future<List<String>> getAllHiddenEventIds() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final hiddenEventIds = <String>[];

    for (final key in keys) {
      if (key.startsWith(_keyPrefix) && prefs.getBool(key) == true) {
        hiddenEventIds.add(key.substring(_keyPrefix.length));
      }
    }

    return hiddenEventIds;
  }
}
