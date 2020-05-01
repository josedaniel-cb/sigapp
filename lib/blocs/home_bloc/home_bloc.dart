import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:SIGApp/app/urls.dart';
import 'package:SIGApp/app/app.dart';
import 'package:SIGApp/models/home_model.dart';
import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeModel homeModel;

  HomeBloc(){
    homeModel = HomeModel('', '', '');
  }
  
  @override
  HomeState get initialState => HomeLoading();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if(event is HomeControllerReady){
      homeModel = event.homeModel;
      yield HomeReady();
    } 

    else if(event is HomeUserLogOut){
      yield HomeLoading();
      App.browserController.cargarUrl(Urls.SALIR);
    } else if(event is HomeControllerLoggedOut){
      yield HomeLogOut();
    } 
    
    else if (event is HomeUserHorario){
      yield HomeLoading();
      App.browserController.cargarUrl(Urls.HORARIO);
    } else if(event is HomeControllerHorario){
      yield HomeHorario();
    }

    else if (event is HomeUserBoletin){
      yield HomeLoading();
      App.browserController.cargarUrl(Urls.BOLETIN);
    } else if(event is HomeControllerBoletin){
      yield HomeBoletin();
    }

    else if (event is HomeUserPlan){
      yield HomeLoading();
      App.browserController.cargarUrl(Urls.PLAN_DE_ESTUDIOS);
    } else if(event is HomeControllerPlan){
      yield HomePlan();
    }

    else if (event is HomeUserProgramacion){
      yield HomeLoading();
      App.browserController.cargarUrl(Urls.PROGRAMACION_ACADEMICA);
    } else if(event is HomeControllerProgramacion){
      yield HomeProgramacion();
    }

    else if (event is HomeUserHistorial){
      yield HomeLoading();
      App.browserController.cargarUrl(Urls.HISTORIAL_ACADEMICO);
    } else if(event is HomeControllerHistorial){
      yield HomeHistorial();
    }

    else if (event is HomeUserInforme){
      yield HomeLoading();
      App.browserController.cargarUrl(Urls.INFORME_ACADEMICO);
    } else if(event is HomeControllerInforme){
      yield HomeInforme();
    }

    else if(event is HomeControllerError){
      yield HomeCriticalError(event.mensaje);
    } 
  }
}
