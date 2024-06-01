import 'dart:async';
import 'dart:io';
import 'dart:convert' show utf8;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

// CÓDIGOS DE USOS
// 1 Horario
// 1.1 Horario > Compartir
// 1.2 Horario > Seleccionar otro semestre
// 2 Boletin
// 2.1 Boletin > Seleccionar otro semestre
// 2.2 Boletin > Notas
// 2.3 Boletin > Silabo
// 3 Plan de Estudios
// 4 Programacion Academica
// 5 Historial Academico
// 5.1 Historial Academico > cambiar pp grafico
// 5.2 Historial Academico > seleccionar semestre
// 6 Informe Académico
// 7 Consulta de pagos
// 8 Plataforma virtual
// 9 SIGA
// 10 Cerrar sesion
// 11 Compartir App
// 12 About
// 13 Terminos y condiciones

class GestorFirebase {
  static const String HORARIO = '1';
  static const String HORARIO_COMPARTIR = '1-1';
  static const String HORARIO_SELEC_SEM = '1-2';
  static const String BOLETIN = '2';
  static const String BOLETIN_SELEC_SEM = '2-1';
  static const String BOLETIN_NOTAS = '2-2';
  static const String BOLETIN_SILABO = '2-3';  
  static const String PLAN = '3';
  static const String PROGRAMACION = '4';
  static const String HISTORIAL = '5';
  static const String HISTORIAL_CAMBIAR_PP_GRAF = '5-1';
  static const String HISTORIAL_SELEC_SEM = '5-2';  
  static const String INFORME = '6';
  static const String CONSULTA_DE_PAGOS = '7';
  static const String PLATAFORMA_VIRTUAL = '8';
  static const String SIGA = '9';
  static const String CERRAR_SESION = '10';
  static const String COMPARTIR_APP = '11';
  static const String ABOUT = '12';
  static const String TERM_Y_COND = '13';
  // static const List<String> LISTA_USOS_CODIGOS = [
  //   HORARIO, HORARIO_COMPARTIR, HORARIO_SELEC_SEM,
  //   BOLETIN, BOLETIN_SELEC_SEM, BOLETIN_NOTAS, BOLETIN_SILABO,
  //   PLAN, 
  //   PROGRAMACION, 
  //   HISTORIAL, HISTORIAL_CAMBIAR_PP_GRAF, HISTORIAL_SELEC_SEM,
  //   INFORME,
  //   CONSULTA_DE_PAGOS, 
  //   PLATAFORMA_VIRTUAL,
  //   SIGA,
  //   CERRAR_SESION, 
  //   COMPARTIR_APP,
  //   ABOUT,
  //   TERM_Y_COND,
  // ];

  final String termCondicPath = 'terminos_y_condiciones.txt';
  final String notaDelAutorPath = 'nota_del_autor.txt';
  // final String coleccionUsuariosID = 'usuarios';
  final String coleccionUsuariosID = 'usuariosA1';
  final String coleccionSesionesID = 'sesiones';
  final String coleccionUsosID = 'usos';
  
  FirebaseFirestore refDatabase;
  DocumentReference refUsuario;
  DocumentReference refSesion;

  String usuarioID;
  String sesionID;  

  GestorFirebase(){
    refDatabase = FirebaseFirestore.instance;
  }

  Future registrarInicioSesion(String codigoUniversitario){
    _print('Registrando sesión de usuario $codigoUniversitario');
    refUsuario = refDatabase.collection(coleccionUsuariosID).doc(codigoUniversitario);    
    refSesion = refUsuario.collection(coleccionSesionesID).doc();  
  
    return refSesion.set({'fecha': Timestamp.now()})
      .then((value) async {
        _print('Sesión registrada con éxito. ID: \'${refSesion.id}\' ✅');
        usuarioID = codigoUniversitario;
        sesionID = refSesion.id;
      })
      .catchError((Object error){
        _print('Sesión registrada sin éxito: $error ❌');
      });
  }

  // void registrarUso(String usoIdentificadorCampo) async {
  //   var refUsuario = Firestore.instance.collection(coleccionUsuariosID).document(usuarioID);    
  //   var refSesion = refUsuario.collection(coleccionSesionesID).document(sesionID);
  //   // var refUso = refSesion.collection(coleccionUsosID).document();
  //   var aux = Timestamp.now();
  //   _print('Registrando uso \'$usoIdentificadorCampo\' de la sesion ${refSesion.documentID} del usuario ${refUsuario.documentID} $aux');
  //   return await Firestore.instance.runTransaction((transaction) async {
  //     DocumentSnapshot freshSnap = await transaction.get(refSesion);
  //     await transaction.update(freshSnap.reference, {
  //       usoIdentificadorCampo: freshSnap[usoIdentificadorCampo] + 1,
  //     });
  //   }).then((value) => _print('Done* ($usoIdentificadorCampo) $aux'));
  // }

  void registrarUso(CasosDeUso casoDeUso) async {
    _print('Registrar uso ${casoDeUso.toString()}');
    var huella = Timestamp.now();
    // var batch = refDatabase.batch();
    var refNuevoUso = refSesion.collection(coleccionUsosID).doc();
    // _print('ID de uso: \'${refNuevoUso.id}\'');
    // batch.set(refNuevoUso, {'uso': _getCodigoCasoDeUso(casoDeUso)});
    refNuevoUso.set({
      'uso': _getCodigoCasoDeUso(casoDeUso),
      'huella': huella,
    })
    .then((value){
      _print('Uso registrado con éxito. ID: \'${refNuevoUso.id}\' ✅');
    })  
    .catchError((Object error){
      _print('Uso registrada sin éxito: $error ❌');
    });
  }

  Future<String> _obtenerArchivoTexto(String path) async {
    // Obtener dirección de descarga 
    _print('Estableciendo referencia a $path');
    Reference refArchivo = FirebaseStorage.instance.ref(path);
    String direccionDescarga = await refArchivo.getDownloadURL();   
    // _print('DownloadURL: $direccionDescarga'); 

    // Descargar archivo
    _print('Descargando $path');
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.parse(direccionDescarga));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    _print('Descarga finalizada'); 

    return utf8.decode(bytes);
  }

  Future<String> obtenerTerminosYCondiciones() async => _obtenerArchivoTexto(termCondicPath);

  Future<String> obtenerNotaDelAutor() async => _obtenerArchivoTexto(notaDelAutorPath);
  
  String _getCodigoCasoDeUso(CasosDeUso caso){
    switch(caso){
      case CasosDeUso.Horario:
        return HORARIO;
        break;
      case CasosDeUso.HorarioCompartir:
        return HORARIO_COMPARTIR;
        break;
      case CasosDeUso.HorarioSeleccionarSemestre:
        return HORARIO_SELEC_SEM;
        break;
      case CasosDeUso.Boletin:
        return BOLETIN;
        break;
      case CasosDeUso.BoletinSeleccionarSemestre:
        return BOLETIN_SELEC_SEM;
        break;
      case CasosDeUso.BoletinNotas:
        return BOLETIN_NOTAS;
        break;
      case CasosDeUso.BoletinSilabo:
        return BOLETIN_SILABO;
        break;
      case CasosDeUso.PlanEstudios:
        return PLAN;
        break;
      case CasosDeUso.ProgramacionAcademica:
        return PROGRAMACION;
        break;
      case CasosDeUso.HistorialAcademico:
        return HISTORIAL;
        break;
      case CasosDeUso.HistorialCambiarGrafico:
        return HISTORIAL_CAMBIAR_PP_GRAF;
        break;
      case CasosDeUso.HistorialSeleccionarSemestre:
        return HISTORIAL_SELEC_SEM;
        break;
      case CasosDeUso.InformeAcademico:
        return INFORME;
        break;
      case CasosDeUso.ConsultaDePagos:
        return CONSULTA_DE_PAGOS;
        break;
      case CasosDeUso.PlataformaVirtual:
        return PLATAFORMA_VIRTUAL;
        break;
      case CasosDeUso.Siga:
        return SIGA;
        break;
      case CasosDeUso.CerrarSesion:
        return CERRAR_SESION;
        break;
      case CasosDeUso.CompartirApp:
        return COMPARTIR_APP;
        break;
      case CasosDeUso.About:
        return ABOUT;
        break;
      case CasosDeUso.TerminosYCondiciones:
        return TERM_Y_COND;
        break;
    }
  }


  void _print(Object object) => print('🥵: $object');
}

enum CasosDeUso{
  Horario, HorarioCompartir, HorarioSeleccionarSemestre,
  Boletin, BoletinSeleccionarSemestre, BoletinNotas, BoletinSilabo,
  PlanEstudios,
  ProgramacionAcademica,
  HistorialAcademico, HistorialCambiarGrafico, HistorialSeleccionarSemestre,
  InformeAcademico,
  ConsultaDePagos,
  PlataformaVirtual,
  Siga,
  CerrarSesion,
  CompartirApp,
  About,
  TerminosYCondiciones,
}