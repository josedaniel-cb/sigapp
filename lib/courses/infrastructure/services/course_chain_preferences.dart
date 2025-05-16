import 'package:shared_preferences/shared_preferences.dart';

class CourseChainPreferences {
  static const String _highlightCriticalPathKey =
      'course_chain_highlight_critical_path';
  static const String _viewModeKey = 'course_chain_view_mode';

  static Future<bool> getHighlightCriticalPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_highlightCriticalPathKey) ?? false;
  }

  static Future<void> setHighlightCriticalPath(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_highlightCriticalPathKey, value);
  }

  static Future<String> getViewMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_viewModeKey) ?? 'tree';
  }

  static Future<void> setViewMode(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_viewModeKey, value);
  }
}
