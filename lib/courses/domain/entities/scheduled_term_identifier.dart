class ScheduledTermIdentifier {
  final int year; // YYYY
  final int period; // X where X is from 0 to 2
  final String id; // 'YYYYX' where X is from 0 to 2
  final String name; // 'YYYY-X'

  ScheduledTermIdentifier._({
    required this.year,
    required this.period,
    required this.id,
    required this.name,
  });

  factory ScheduledTermIdentifier.buildFromId(String id) {
    final year = int.parse(id.substring(0, 4));
    final period = int.parse(id.substring(4));
    final name = '$year-$period';
    return ScheduledTermIdentifier._(
      id: id,
      name: name,
      year: year,
      period: period,
    );
  }

  // static String getIdFromName(String name) {
  //   final parts = name.split('-');
  //   return '${parts[0]}${parts[1]}';
  // }
  factory ScheduledTermIdentifier.buildFromName(String name) {
    final parts = name.split('-');
    final year = int.parse(parts[0]);
    final period = int.parse(parts[1]);
    final id = '$year$period';
    return ScheduledTermIdentifier._(
      id: id,
      name: name,
      year: year,
      period: period,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScheduledTermIdentifier && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  bool operator <(ScheduledTermIdentifier other) => id.compareTo(other.id) < 0;
  bool operator <=(ScheduledTermIdentifier other) =>
      id.compareTo(other.id) <= 0;
  bool operator >(ScheduledTermIdentifier other) => id.compareTo(other.id) > 0;
  bool operator >=(ScheduledTermIdentifier other) =>
      id.compareTo(other.id) >= 0;
}
