class DateUtils {
  DateUtils._();

  /// Example: For `'2021/11/18'` it returns
  /// `'2021-11-18T00:00:00.000'` `DateTime` object.
  static DateTime parseFormattedDate(String date) {
    final parts = date.split('/');
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }
}
