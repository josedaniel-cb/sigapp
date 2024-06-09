import 'package:bloc/bloc.dart';
import 'package:sigapp/models/informe_model.dart';
import './bloc.dart';

class InformeBloc extends Bloc<InformeEvent, InformeState> {
  late InformeModel modelo;

  InformeBloc() : super(Loading()) {
    on<InformeEvent>(_onInformeEventReceived);
  }

  void _onInformeEventReceived(
      InformeEvent event, Emitter<InformeState> emit) async {
    if (event is InformeControllerReady) {
      modelo = event.modelo;
      emit(Ready());
    }
  }
}
