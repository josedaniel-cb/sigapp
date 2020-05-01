import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:SIGApp/models/informe_model.dart';
import './bloc.dart';

class InformeBloc extends Bloc<InformeEvent, InformeState> {
  InformeModel modelo;

  @override
  InformeState get initialState => Loading();

  @override
  Stream<InformeState> mapEventToState(
    InformeEvent event,
  ) async* {
    if(event is InformeControllerReady){
      modelo = event.modelo;
      yield Ready();
    }
  }
}
