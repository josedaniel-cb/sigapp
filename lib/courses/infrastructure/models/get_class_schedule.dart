import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_class_schedule.freezed.dart';
part 'get_class_schedule.g.dart';

@freezed
abstract class GetClassScheduleModel with _$GetClassScheduleModel {
  factory GetClassScheduleModel({
    required String HoraFinal,
    required String HoraInicio,
    required String Lunes,
    required String Martes,
    required String Miercoles,
    required String Jueves,
    required String Viernes,
    required String Sabado,
  }) = _GetClassScheduleModel;

  factory GetClassScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$GetClassScheduleModelFromJson(json);
}
