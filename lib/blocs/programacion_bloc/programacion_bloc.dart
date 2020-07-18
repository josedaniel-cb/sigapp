import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:SIGApp/models/programacion_model.dart';
import './bloc.dart';

class ProgramacionBloc extends Bloc<ProgramacionEvent, ProgramacionState> {
  ProgramacionModel modelo;

  // @override
  // ProgramacionState get initialState => Loading();
  ProgramacionBloc() : super(Loading());

  @override
  Stream<ProgramacionState> mapEventToState(
    ProgramacionEvent event,
  ) async* {
    if (event is ProgramacionControllerReady) {
      modelo = event.modelo;
      yield Ready();
    }
  }
}
