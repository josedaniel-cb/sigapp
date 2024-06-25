import 'package:injectable/injectable.dart';
import 'package:sigapp/student/models/get_academic_report.dart';
import 'package:sigapp/student/models/get_class_schedule.dart';
import 'package:sigapp/student/student_repository.dart';

@lazySingleton
class StudentService {
  final StudentRepository _studentRepository;

  GetAcademicReportModel? _academicReportModel;

  StudentService(this._studentRepository);

  Future<GetAcademicReportModel> getAcademicReport() async {
    if (_academicReportModel != null) {
      return _academicReportModel!;
    }

    _academicReportModel = await _studentRepository.getAcademicReport();

    return _academicReportModel!;
  }

  Future<List<GetClassScheduleModel>> getClassSchedule(String semester) async {
    final result = await _studentRepository.getClassSchedule(semester);
    return result;
  }
}
