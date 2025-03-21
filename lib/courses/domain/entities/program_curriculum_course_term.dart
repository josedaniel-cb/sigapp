import 'package:sigapp/courses/domain/entities/course_type.dart';

class ProgramCurriculumCourseInfo {
  final String courseCode;
  final int credits;
  final String courseName;
  final CourseType courseType;
  final int practiceHours;
  final int theoryHours;
  final int termNumber;
  final List<String> requirementCourseCodes;

  ProgramCurriculumCourseInfo({
    required this.courseCode,
    required this.credits,
    required this.courseName,
    required this.courseType,
    required this.practiceHours,
    required this.theoryHours,
    required this.termNumber,
    required this.requirementCourseCodes,
  });
}

class ProgramCurriculumCourse {
  final ProgramCurriculumCourseInfo info;
  final List<ProgramCurriculumCourseInfo> requirements;
  int? lastGrade;

  ProgramCurriculumCourse({
    required this.info,
    required this.requirements,
  });

  bool get isApproved => lastGrade != null && lastGrade! >= 11;
}

class ProgramCurriculumTerm {
  final int termNumber;
  final List<ProgramCurriculumCourse> courses;

  ProgramCurriculumTerm({
    required this.termNumber,
    required this.courses,
  });

  String get termRomanNumeral {
    final labelsMap = <int, String>{
      1: 'I',
      2: 'II',
      3: 'III',
      4: 'IV',
      5: 'V',
      6: 'VI',
      7: 'VII',
      8: 'VIII',
      9: 'IX',
      10: 'X',
      11: 'XI',
      12: 'XII',
    };
    final label = labelsMap[termNumber];
    if (label != null) return label;
    return termNumber.toString();
  }
}
