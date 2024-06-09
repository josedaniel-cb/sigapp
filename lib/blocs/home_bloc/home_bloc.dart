import 'package:bloc/bloc.dart';
import 'package:sigapp/app/urls.dart';
import 'package:sigapp/app/app.dart';
import 'package:sigapp/models/home_model.dart';
import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late HomeModel homeModel;

  HomeBloc() : super(HomeLoading()) {
    homeModel = HomeModel('', '', '');
    on<HomeEvent>(_onEventReceived);
  }

  void _onEventReceived(HomeEvent event, Emitter<HomeState> emit) async {
    if (event is HomeControllerReady) {
      homeModel = event.homeModel;
      emit(HomeReady());
    } else if (event is HomeUserLogOut) {
      emit(HomeLoading());
      App.browserController.cargarUrl(Urls.SALIR);
    } else if (event is HomeControllerLoggedOut) {
      emit(HomeLogOut());
    } else if (event is HomeUserHorario) {
      emit(HomeLoading());
      App.browserController.cargarUrl(Urls.HORARIO);
    } else if (event is HomeControllerHorario) {
      emit(HomeHorario());
    } else if (event is HomeUserBoletin) {
      emit(HomeLoading());
      App.browserController.cargarUrl(Urls.BOLETIN);
    } else if (event is HomeControllerBoletin) {
      emit(HomeBoletin());
    } else if (event is HomeUserPlan) {
      emit(HomeLoading());
      App.browserController.cargarUrl(Urls.PLAN_DE_ESTUDIOS);
    } else if (event is HomeControllerPlan) {
      emit(HomePlan());
    } else if (event is HomeUserProgramacion) {
      emit(HomeLoading());
      App.browserController.cargarUrl(Urls.PROGRAMACION_ACADEMICA);
    } else if (event is HomeControllerProgramacion) {
      emit(HomeProgramacion());
    } else if (event is HomeUserHistorial) {
      emit(HomeLoading());
      App.browserController.cargarUrl(Urls.HISTORIAL_ACADEMICO);
    } else if (event is HomeControllerHistorial) {
      emit(HomeHistorial());
    } else if (event is HomeUserInforme) {
      emit(HomeLoading());
      App.browserController.cargarUrl(Urls.INFORME_ACADEMICO);
    } else if (event is HomeControllerInforme) {
      emit(HomeInforme());
    } else if (event is HomeControllerError) {
      emit(HomeCriticalError(event.mensaje));
    }
  }
}
