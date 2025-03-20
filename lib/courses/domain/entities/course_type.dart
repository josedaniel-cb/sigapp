enum CourseType {
  mandatory('O'),
  elective('E');

  final String value;

  const CourseType(this.value);

  static CourseType fromValue(String value) {
    switch (value) {
      case 'O':
        return mandatory;
      case 'E':
        return elective;
      default:
        throw Exception('Invalid course type value: $value');
    }
  }
}
