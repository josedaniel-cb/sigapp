import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

abstract class ProgressIndicatorState {}

class ProgressIndicatorVisible extends ProgressIndicatorState {}

class ProgressIndicatorHidden extends ProgressIndicatorState {}

@singleton
class ProgressIndicatorBloc extends Cubit<ProgressIndicatorState> {
  ProgressIndicatorBloc() : super(ProgressIndicatorHidden());

  Future<void> show() async {
    emit(ProgressIndicatorVisible());
    await Future.delayed(Duration(milliseconds: 100));
  }

  Future<void> hide() async {
    emit(ProgressIndicatorHidden());
    await Future.delayed(Duration(milliseconds: 100));
  }
}
