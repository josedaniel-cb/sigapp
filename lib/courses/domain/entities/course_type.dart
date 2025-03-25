enum CourseType {
  mandatory('O'),
  elective('E');

  final String value;

  const CourseType(this.value);

  static CourseType fromValue(String value) {
    final enum_ = CourseType.fromValueOrNull(value);
    if (enum_ == null) {
      throw ArgumentError('Invalid CourseType value: "$value"');
    }
    return enum_;
  }

  static CourseType? fromValueOrNull(String value) {
    switch (value) {
      case 'O':
        return mandatory;
      case 'E':
        return elective;
      default:
        return null;
    }
  }
}
