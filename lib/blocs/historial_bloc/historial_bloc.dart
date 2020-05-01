import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:SIGApp/models/historial_model.dart';
import './bloc.dart';

class HistorialBloc extends Bloc<HistorialEvent, HistorialState> {
  HistorialModel modelo;

  @override
  HistorialState get initialState => Loading();

  @override
  Stream<HistorialState> mapEventToState(
    HistorialEvent event,
  ) async* {
    if(event is HistorialControllerReady){
      modelo = event.modelo;
      yield Ready();
    }
  }
}
