class ListUtils {
  static String formatList(List<String> items, {String conjunction = 'y'}) {
    if (items.isEmpty) return '';
    if (items.length == 1) return items.first;
    if (items.length == 2) return '${items.first} $conjunction ${items.last}';

    final allButLast = items.sublist(0, items.length - 1).join(', ');
    return '$allButLast $conjunction ${items.last}';
  }
}
