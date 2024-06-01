import 'package:flutter/material.dart' show Color, debugPrint;
import 'package:html/dom.dart';
import 'package:SIGApp/app/urls.dart';
// import 'package:SIGApp/app/urls.dart';
import 'package:SIGApp/models/boletin_model/boletin_model.dart';
import 'package:SIGApp/models/boletin_model/curso_boletin_model.dart';
import 'package:SIGApp/models/notas_model.dart';
import 'package:SIGApp/models/curso_model/curso_caracteristica.dart';
import 'package:SIGApp/models/curso_model/curso_model.dart';
import 'package:SIGApp/models/historial_model.dart';
import 'package:SIGApp/models/home_model.dart';
import 'package:SIGApp/models/horario_model/casillero_horario.dart';
import 'package:SIGApp/models/horario_model/curso_horario.dart';
import 'package:SIGApp/models/horario_model/fila_horario.dart';
import 'package:SIGApp/models/horario_model/hora_horario.dart';
import 'package:SIGApp/models/horario_model/horario_model.dart';
import 'package:SIGApp/models/informe_model.dart';
import 'package:SIGApp/models/plan_model/plan_model.dart';
import 'package:SIGApp/models/programacion_model.dart';

class Scraper {
  static const String tagTabla = 'table';
  static const String tagCuerpoTabla = 'tbody';
  static const String tagFilaTabla = 'tr';
  static const String tagCasilleroTabla = 'td';
  static const String tagParrafo = 'p';
  static const String tagLeyenda = 'legend';
  static const String tagHeading2 = 'h2';
  static const String tagHeading3 = 'h3';
  static const String tagHeading4 = 'h4';
  static const String tagHeading5 = 'h5';
  static const String tagFieldset = 'fieldset';
  static const String tagLegend = 'legend';
  static const String tagListItem = 'li';
  static const String tagUnorderedList = 'ul';
  static const String tagCenter = 'center';
  static const String tagDivision = 'div';

  static const String classLoadingMask = 'k-loading-mask';
  static const String classOption = 'option';
  static const String classTextCenter = 'text-center';

  static const String classIconRefresh = 'k-icon k-i-refresh';

  static const String classKGridWidget = 'k-grid k-widget';
  static const String classKGridToolbar = 'k-toolbar k-grid-toolbar';
  static const String classKGridContent = 'k-grid-content';

  // Notas
  static const String classPanelDefault = 'panel panel-default';
  static const String classLblCriterio = 'lbl-criterio';
  static const String classLblPromedio =
      'label label-success arrowed arrowed-in-right pull-right ';
  static const String classLblPorcentaje =
      'label label-info arrowed pull-right ';

  static const String classAlertInfo = 'center alert alert-info bolder';

  static const String classBadgeInfo = 'badge badge-info';
  static const String classBadgeSuccess = 'badge badge-success';
  static const String classBadgeDanger = 'badge badge-danger';

  // static const String classCenterAlert ='center alert alert-info bolder';
  static const String classPanelBody = 'panel-body';
  static const String classPanelHeading = 'panel-heading';

  static const String tagBold = 'b';
  static const String tagItalic = 'i';
  static const String tagSpan = 'span';
  // static const String tagBreak ='br';
  // static const String idAsistencia ='asistencia';
  // static const String idNotas ='notas';

  static const String styleAttribute = 'style';

  static String? acondicionarHtmlData(htmlData) {
    htmlData = htmlData.substring(1, htmlData.length - 1);

    /// Nota:
    /// '\u003C' = '<'
    htmlData = htmlData.replaceAll(RegExp(r'\\u003C'), '<');
    htmlData = htmlData.replaceAll(RegExp(r'\\n'), '\n');
    htmlData = htmlData.replaceAll(RegExp(r'\\t'), '\t');
    htmlData = htmlData.replaceAll(RegExp(r'\\"'), '\"');
    return htmlData;
  }

  // Generico
  static bool estaCargandoTabla(Document document) {
    return document.getElementsByClassName(classLoadingMask).length > 0;
  }

  static bool cuerpoTablaCargado(Document document) {
    return document
            .getElementsByTagName(tagCuerpoTabla)[0]
            .getElementsByTagName(tagFilaTabla)
            .length >
        0;
  }

  static List<String> browserGenerarListaSemestres(Document document) {
    List<Element> elementos = document.getElementsByTagName(classOption);
    List<String> semestres = [];
    elementos.forEach((opcion) {
      semestres.add(opcion.innerHtml);
    });
    return semestres;
  }

  // Home
  static HomeModel homeObtenerDatos(Document document) {
    String usuario = document.getElementsByTagName('dd')[0].innerHtml;
    String escuela = document.getElementsByTagName('dd')[1].innerHtml;
    _print('usuario: \'$usuario\', escuela: \'$escuela\'');
    String apellidosNombres = usuario.substring(13, usuario.length).trim();
    // Obtener inciales
    String iniciales = '';
    String nombres = apellidosNombres.split(',')[1];
    int i = 0;
    while (i < nombres.length - 1 && iniciales.length < 2) {
      if (nombres[i].compareTo(" ") == 0) {
        if (nombres[i + 1].compareTo(" ") != 0) {
          iniciales = iniciales + nombres[i + 1];
        }
      }
      i++;
    }
    // _print('generarHomeModel retorna HomeModel(\'$iniciales\', \'$apellidosNombres\', \'$escuela\')');
    return HomeModel(iniciales, apellidosNombres, escuela);
  }

  // Horario
  static HorarioModel horarioGenerarModelo(Document document) {
    Element tabla, nodoAula;
    List<Element> filas, casilleros;
    HorarioModel modelo;
    HoraHorario inicio, fin;
    int i;
    CursoHorario? curso;
    Color colorTexto, colorFondo;
    String nombreCurso, nombreAula;
    FilaHorario filaHorario;

    tabla = _obtenerTabla(document);
    filas = tabla.getElementsByTagName(tagFilaTabla);
    modelo = HorarioModel();
    filas.forEach((fila) {
      casilleros = fila.getElementsByTagName(tagCasilleroTabla);
      inicio = _horarioGenerarHoraHorario(casilleros[0].text);
      fin = _horarioGenerarHoraHorario(casilleros[1].text);
      filaHorario = FilaHorario(inicio, fin);
      for (i = 2; i < casilleros.length - 1; i++) {
        // _print("se evaluar[a casilleros[i].text \'${casilleros[i].text}\'");
        // _print("se evaluar[a casilleros[i].text.length \'${casilleros[i].text.length}\'");
        // if(casilleros[i].text.isEmpty){
        if (casilleros[i].text.length != 0) {
          colorFondo = _horarioObtenerCasilleroColorFondo(
              casilleros[i].attributes[styleAttribute]!);
          colorTexto = _horarioObtenerCasilleroColorTexto(colorFondo);
          nodoAula = casilleros[i].getElementsByTagName(tagParrafo)[0];
          nombreAula = nodoAula.text;
          nodoAula.remove();
          nombreCurso = casilleros[i].text;
          curso = CursoHorario(nombreCurso, nombreAula, colorTexto, colorFondo);
        } else {
          curso = null;
        }
        filaHorario.cursos.add(CasilleroHorario(curso));
      }
      modelo.filas.add(filaHorario);
    });
    // return modelo;
    return _horarioNormalizarModelo(modelo);
  }

  static HoraHorario _horarioGenerarHoraHorario(String horaData) {
    // Formato esperado: ' 02:00 PM'
    int horas, minutos;
    String formato;

    horaData = horaData.trim();
    horas = int.parse(horaData.substring(0, 2));
    minutos = int.parse(horaData.substring(3, 5));
    formato = horaData.substring(6, 8);
    if (formato.compareTo('PM') == 0 && horas < 12) {
      horas += 12;
    }

    return HoraHorario(horas, minutos);
  }

  static Color _horarioObtenerCasilleroColorFondo(String colorData) {
    Color color;
    List<String> rgb;
    // _print("_horarioObtenerCasilleroColorFondo" + colorData);
    rgb = colorData.substring(22, colorData.length - 16).split(', ');
    if (rgb.length > 0) {
      // Se espera length == 3
      color = Color.fromRGBO(
          int.parse(rgb[0]), int.parse(rgb[1]), int.parse(rgb[2]), 1.0);
    } else {
      color = Color.fromRGBO(0, 0, 0, .1);
    }
    // _print('retornando color: \'$color\'');
    return color;
  }

  static Color _horarioObtenerCasilleroColorTexto(Color color) {
    int d = 0;

    // Counting the perceptive luminance - human eye favors green color...
    double luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

    if (luminance > 0.5)
      d = 0; // bright colors - black font
    else
      d = 255; // dark colors - white font

    return Color.fromARGB(color.alpha, d, d, d);
  }

  static HorarioModel _horarioNormalizarModelo(HorarioModel modelo) {
    int i, j;
    List<int> arriba, abajo, remover;

    /// Determinar qué fila se mudará a su fila siguiente (como [curso1] en cada casillero)
    abajo = [];
    i = 0;
    while (i < modelo.filas.length - 1) {
      if (modelo.filas[i].inicio.horas == modelo.filas[i + 1].inicio.horas &&
          modelo.filas[i].inicio.minutos ==
              modelo.filas[i + 1].inicio.minutos) {
        abajo.add(i);
      }
      i++;
    }

    /// Determinar qué fila se mudará a su fila anterior (como [curso2] en cada casillero)
    arriba = [];
    i = 1;
    while (i < modelo.filas.length) {
      if (modelo.filas[i].fin.horas == modelo.filas[i - 1].fin.horas &&
          modelo.filas[i].fin.minutos == modelo.filas[i - 1].fin.minutos) {
        arriba.add(i);
      }
      i++;
    }

    // Mudar 1
    for (i = 0; i < abajo.length; i++) {
      for (j = 0; j < modelo.filas[abajo[i]].cursos.length; j++) {
        if (modelo.filas[abajo[i]].cursos[j].curso1 != null) {
          modelo.filas[abajo[i] + 1].cursos[j].curso1 =
              modelo.filas[abajo[i]].cursos[j].curso1;
        }
      }
    }

    // Mudar 2
    for (i = 0; i < arriba.length; i++) {
      for (j = 0; j < modelo.filas[arriba[i]].cursos.length; j++) {
        if (modelo.filas[arriba[i]].cursos[j].curso1 != null) {
          modelo.filas[arriba[i] - 1].cursos[j].curso2 =
              modelo.filas[arriba[i]].cursos[j].curso1;
        }
      }
    }

    // Unir
    remover = abajo;
    for (i = 0; i < arriba.length; i++) {
      /// Buscar lugar adecuado para insertar [desplazarHaciaArriba[i]]
      j = 0;
      while (j < remover.length && arriba[i] > remover[j]) {
        j++;
      }
      if (j != remover.length) {
        remover.insert(j, arriba[i]);
      } else {
        remover.add(arriba[i]);
      }
    }

    // Remover filas sobrantes
    for (i = remover.length - 1; i >= 0; i--) {
      modelo.filas.removeAt(remover[i]);
    }

    return modelo;
  }

  // Boletin
  static BoletinModel boletinGenerarModelo(Document document) {
    BoletinModel modelo;
    List<Element> filasTabla, casillerosFila;
    CursoBoletinModel nuevoCurso;
    int i;
    String? aux;

    modelo = BoletinModel();
    filasTabla = _obtenerTabla(document).getElementsByTagName(tagFilaTabla);
    _print('boletinGenerarModelo');
    _print('filasTabla.length: ${filasTabla.length}');
    for (i = 0; i < filasTabla.length; i++) {
      casillerosFila = filasTabla[i].getElementsByTagName(tagCasilleroTabla);
      nuevoCurso = CursoBoletinModel(
          casillerosFila[1].getElementsByTagName('a')[0].text,
          casillerosFila[0].text);

      // nuevoCurso.caracteristicas.add(CursoCaracteristica('Créditos', casillerosFila[3].text));
      // nuevoCurso.caracteristicas.add(CursoCaracteristica('Clave', casillerosFila[4].text));
      // nuevoCurso.caracteristicas.add(CursoCaracteristica('Profesor', casillerosFila[5].text));
      // nuevoCurso.caracteristicas.add(CursoCaracteristica('Aula', casillerosFila[7].text));
      // nuevoCurso.caracteristicas.add(CursoCaracteristica('Grupo', casillerosFila[8].text));
      // nuevoCurso.caracteristicas.add(CursoCaracteristica('Sección', casillerosFila[6].text));
      // nuevoCurso.caracteristicas.add(CursoCaracteristica('Observación', casillerosFila[2].text));
      // nuevoCurso.caracteristicas.add(CursoCaracteristica('Fecha de inscripción', casillerosFila[9].text));
      // nuevoCurso.caracteristicas.add(CursoCaracteristica('Acta', casillerosFila[10].text));
      nuevoCurso.caracteristicas.add(CursoCaracteristica(
          CursoCaracteristica.creditos, casillerosFila[3].text));
      nuevoCurso.caracteristicas.add(CursoCaracteristica(
          CursoCaracteristica.clave, casillerosFila[4].text));
      nuevoCurso.caracteristicas.add(CursoCaracteristica(
          CursoCaracteristica.profesor, casillerosFila[5].text));
      nuevoCurso.caracteristicas.add(CursoCaracteristica(
          CursoCaracteristica.aula, casillerosFila[7].text));
      nuevoCurso.caracteristicas.add(CursoCaracteristica(
          CursoCaracteristica.grupo, casillerosFila[8].text));
      nuevoCurso.caracteristicas.add(CursoCaracteristica(
          CursoCaracteristica.seccion, casillerosFila[6].text));
      nuevoCurso.caracteristicas.add(CursoCaracteristica(
          CursoCaracteristica.observacion, casillerosFila[2].text));
      nuevoCurso.caracteristicas.add(CursoCaracteristica(
          CursoCaracteristica.fechaDeInscripcion, casillerosFila[9].text));
      nuevoCurso.caracteristicas.add(CursoCaracteristica(
          CursoCaracteristica.acta, casillerosFila[10].text));

      nuevoCurso.silaboUrl = casillerosFila[11]
          .getElementsByTagName('a')[0]
          .attributes['onclick']!
          .substring(13, 67);

      aux =
          casillerosFila[11].getElementsByTagName('a')[0].attributes['onclick'];
      aux = aux!.split(',')[0];
      // nuevoCurso.notasUrl = Urls.NOTAS + aux.substring(aux.length - 11, aux.length - 1);

      modelo.cursos.add(nuevoCurso);
    }

    return modelo;
  }

  // Notas
  static NotasModel notasGenerarModelo(Document document) {
    List<CriterioEvaluacionNotasModel> criterios;
    List<Element> listaCriterios, listaSpans;
    Element? notasPanel, panelNotas;
    // Element asistenciasPanel;
    // int aiststTotClases, aiststTotales, aiststTotFaltas;
    // List<String> asistencias;
    CursoModel? cursoModelo;
    double? notaSusti, notaFinal;
    String? estado, descripcionError, notaFinalLabel;

    criterios = [];

    notasPanel = document.getElementById('notas');
    if (notasPanel != null) {
      // Criterios
      listaCriterios = notasPanel.getElementsByClassName(classPanelDefault);
      listaCriterios.forEach((Element panelDefault) {
        criterios.add(_notasObtenerCriterioModel(panelDefault));
      });

      // Curso info
      cursoModelo = CursoModel(
          document.getElementsByTagName(tagHeading3)[0].text.trim(), null);
      listaSpans = document
          .getElementsByTagName(tagDivision)[6]
          .getElementsByTagName(tagSpan);
      cursoModelo.caracteristicas.add(CursoCaracteristica(
          CursoCaracteristica.profesor, listaSpans[1].innerHtml.trim()));
      cursoModelo.caracteristicas.add(CursoCaracteristica(
          CursoCaracteristica.grupo, listaSpans[3].innerHtml.trim()));
      cursoModelo.caracteristicas.add(CursoCaracteristica(
          CursoCaracteristica.aula, listaSpans[5].innerHtml.trim()));
      cursoModelo.caracteristicas.add(CursoCaracteristica(
          CursoCaracteristica.seccion, listaSpans[7].innerHtml.trim()));

      // Asistencias
      // asistenciasPanel = document.getElementById('asistencia');
      // asistencias = asistenciasPanel.getElementsByTagName(tagCenter)[0].innerHtml.split('<br>');
      // // asistencias.forEach((String e){_print('asistencias... \'$e\'');});
      // for(int i = 0; i < asistencias.length; i++){
      //   asistencias[i] = asistencias[i].trim();
      // }
      // // aiststTotClases = int.parse(asistencias[0]);
      // aiststTotClases = int.parse(asistencias[0].split(' ')[3]);
      // aiststTotales = int.parse(asistencias[1].split(' ')[3]);
      // aiststTotFaltas = int.parse(asistencias[2].split(' ')[3]);

      // Nota final
      panelNotas = notasPanel.getElementsByClassName(classAlertInfo)[0];

      listaSpans = panelNotas.getElementsByTagName(tagSpan);
      if (listaSpans.length == 1) {
        _print(notasPanel.getElementsByClassName(classAlertInfo)[0].text);
        notaFinal = double.parse(listaSpans[0].innerHtml.trim());
      } else if (listaSpans.length == 2) {
        estado = listaSpans[0].innerHtml.trim();
        notaFinal = double.parse(listaSpans[1].innerHtml.trim());
      } else {
        notaSusti = double.parse(listaSpans[1].innerHtml.trim());
        estado = listaSpans[2].innerHtml.trim();
        notaFinal = double.parse(listaSpans[3].innerHtml.trim());
      }

      listaSpans.forEach((Element spanE) {
        spanE.remove();
      });
      notaFinalLabel = panelNotas.text.trim();
      if (notaFinalLabel.endsWith(':')) {
        notaFinalLabel = notaFinalLabel.substring(0, notaFinalLabel.length - 1);
      }
    } else {
      List<Element> error404 = document.getElementsByTagName(tagHeading2);
      if (error404.length > 0) {
        if (error404[0]
                .innerHtml
                .compareTo('404: archivo o directorio no encontrado.') ==
            0) {
          descripcionError = 'Error de servidor';
        } else {
          descripcionError = 'Ha ocurrido un error';
        }
      } else {
        descripcionError = 'El docente aún no ha programado exámenes';
      }
    }

    return NotasModel(
      criterios: criterios,
      // asistenciasTotalAsistencias: aiststTotales,
      // asistenciasTotalClases: aiststTotClases,
      // asistenciasTotalFaltas: aiststTotFaltas,
      curso: cursoModelo,
      notaFinal: notaFinal,
      estadoLabel: estado,
      notaSustitutorio: notaSusti,
      error: descripcionError,
      notaFinalLabel: notaFinalLabel,
    );
  }

  static CriterioEvaluacionNotasModel _notasObtenerCriterioModel(
      Element panelDefault) {
    //classPanelDefault ='panel panel-default'
    String titulo, porcentajeString, notaString, comentario;
    int porcentaje;
    double nota;
    Element elemPanelBody, elemPanelHeading;
    List<Element> elemExamenes, elemSpanHeading;
    List<ExamenNotasModel> examenes;
    // ExamenNotasModel nuevoEx;

    elemPanelHeading =
        panelDefault.getElementsByClassName(classPanelHeading)[0];
    elemSpanHeading = elemPanelHeading.getElementsByTagName(tagSpan);

    titulo = elemSpanHeading[1].text.trim();

    porcentajeString =
        elemSpanHeading[2].getElementsByTagName(tagBold)[0].text.trim();
    porcentaje = int.parse(porcentajeString.split(' ')[0]);

    notaString =
        elemSpanHeading[4].getElementsByTagName(tagBold)[0].text.trim();
    nota = double.parse(notaString);

    elemPanelBody = panelDefault.getElementsByClassName(classPanelBody)[0];

    examenes = [];
    elemExamenes = elemPanelBody.getElementsByTagName(tagListItem);
    elemExamenes.forEach((Element examenElement) {
      examenes.add(_notasObtenerExamenModel(examenElement));
    });

    // _print(elemPanelBody.innerHtml);
    elemPanelBody.getElementsByTagName(tagUnorderedList)[0].remove();
    comentario = elemPanelBody.text.trim();

    return CriterioEvaluacionNotasModel(
      titulo: titulo,
      notaPromedio: nota,
      porcentaje: porcentaje,
      mensaje: comentario,
      examenes: examenes,
    );
  }

  static ExamenNotasModel _notasObtenerExamenModel(Element examenElement) {
    List<Element> listaSpans = examenElement.getElementsByTagName(tagSpan);
    String? fechaRegistro;
    List<Element> listaItalics = examenElement.getElementsByTagName(tagItalic);
    if (listaItalics.length != 0) {
      fechaRegistro =
          examenElement.getElementsByTagName(tagItalic)[0].text.split(' ')[1];
    }
    return ExamenNotasModel(
        listaSpans[1].text, fechaRegistro, double.parse(listaSpans[3].text));
  }

  // Plan de estudios
  static PlanModel planGenerarModelo(Document document) {
    String nombrePlan;
    PlanModel modelo;
    List<Element> filas;
    int i, j;
    List<List<Element>> matriz;
    CicloPlanModel? nuevoCiclo;

    // _print('planGenerarModelo($document)');

    nombrePlan = document.getElementsByTagName(tagLeyenda)[0].text.trim();
    nombrePlan = nombrePlan.substring(nombrePlan.length - 6, nombrePlan.length);
    modelo = PlanModel(nombrePlan);

    // Obtener todas las filas
    filas = document
        .getElementsByTagName(tagCuerpoTabla)[0]
        .getElementsByTagName(tagFilaTabla);
    matriz = [];
    for (i = 0; i < filas.length; i++) {
      // _print('filas[$i].innerHtml: ${filas[i].innerHtml}');
      matriz.add(filas[i].getElementsByTagName(tagCasilleroTabla));
    }

    if (matriz.length > 0) {
      // Crear el primer ciclo, si la tabla no esta vacía
      nuevoCiclo = CicloPlanModel(matriz[0][0].text.trim());
    }
    i = 1;
    while (i < matriz.length) {
      // Ir armando plan
      if (matriz[i].length == 1) {
        modelo.ciclos.add(nuevoCiclo);
        nuevoCiclo = CicloPlanModel(matriz[i][0].text.trim());
      } else {
        nuevoCiclo!.cursos!.add(CursoPlanModel(
            matriz[i][3].text.trim(), matriz[i][2].text)
          ..caracteristicas.add(CursoCaracteristica(
              CursoCaracteristica.requisitos, matriz[i][4].text))
          ..caracteristicas.add(
              CursoCaracteristica(CursoCaracteristica.tipo, matriz[i][5].text))
          ..caracteristicas.add(CursoCaracteristica(
              CursoCaracteristica.creditos, matriz[i][6].text)));
      }
      i++;
    }
    if (i > 1 && i == matriz.length) {
      // agregar el ultimo ciclo que se recopiló
      modelo.ciclos.add(nuevoCiclo);
    }

    for (i = 0; i < modelo.ciclos.length; i++) {
      for (j = 0; j < modelo.ciclos[i]!.cursos!.length; j++) {
        modelo.ciclos[i]!.cursos![j].requisitos = _boletinGenerarRequisitos(
            modelo, modelo.ciclos[i]!.cursos![j].requisitosData);
        modelo.ciclos[i]!.cursos![j].caracteristicas
            .removeAt(0); // Eliminar requisitos
      }
    }

    return modelo;
  }

  static List<RequisitoCursoPlanModel> _boletinGenerarRequisitos(
      PlanModel modelo, String requisitosData) {
    List<RequisitoCursoPlanModel> requisitos;
    List<String> codigosCurso;
    int? i, j;
    bool ban;

    // _print('_boletinGenerarRequisitos($modelo, $requisitosData) {...');
    requisitos = [];
    requisitosData = requisitosData.trim();
    if (requisitosData.length > 3) {
      // evitar "---"
      codigosCurso = requisitosData.split(' - '); // ejemplo: "IO4447 - SI4488"
      codigosCurso.forEach((codigo) {
        // _print('codigosCurso.forEach(($codigo){...}');
        ban = true;
        i = 0;
        while (i! < modelo.ciclos.length && ban) {
          j = 0;
          while (j! < modelo.ciclos[i!]!.cursos!.length &&
              modelo.ciclos[i!]!.cursos![j!].codigo!.compareTo(codigo) != 0) {
            // j++;
            j = j! + 1;
          }
          if (j! < modelo.ciclos[i!]!.cursos!.length) {
            ban = false; // el curso fue encontrado
          }
          // i++;
          i = i! + 1;
        }
        if (!ban) {
          // el curso fue encontrado
          // i--;
          i = i! - 1;
          requisitos.add(RequisitoCursoPlanModel(i, j));
        }
      });
    }

    return requisitos;
  }

  // Programación Académica
  static ProgramacionModel programacionGenerarModelo(Document document) {
    ProgramacionModel modelo;
    List<Element> cursosElementos, caracteristicasCurso;
    int i;

    modelo = ProgramacionModel(
        document.getElementsByTagName(tagLegend)[0].text.split(' ')[4]);
    cursosElementos = document
        .getElementsByTagName(tagCuerpoTabla)[0]
        .getElementsByTagName(tagFilaTabla);
    for (i = 0; i < cursosElementos.length; i++) {
      caracteristicasCurso =
          cursosElementos[i].getElementsByTagName(tagCasilleroTabla);
      modelo.cursos.add(CursoModel(
          caracteristicasCurso[2].text, caracteristicasCurso[0].text)
        ..caracteristicas.add(CursoCaracteristica(
            CursoCaracteristica.clave, caracteristicasCurso[1].text))
        ..caracteristicas.add(CursoCaracteristica(
            CursoCaracteristica.grupo, caracteristicasCurso[3].text))
        ..caracteristicas.add(CursoCaracteristica(
            CursoCaracteristica.seccion, caracteristicasCurso[4].text))
        ..caracteristicas.add(CursoCaracteristica(
            CursoCaracteristica.docenteTeoria, caracteristicasCurso[5].text))
        ..caracteristicas.add(CursoCaracteristica(
            CursoCaracteristica.aula, caracteristicasCurso[6].text))
        ..caracteristicas.add(CursoCaracteristica(
            CursoCaracteristica.capacidad, caracteristicasCurso[7].text)));
    }

    return modelo;
  }

  // Historial Académico
  static HistorialModel historialGenerarModelo(Document document) {
    HistorialModel modelo;
    List<String> etiquetasSemestres;
    List<Element> elemEtiqSeme, elemTablaSeme;
    List<List<List<dynamic>>?> matricesDeInformacion;
    List<List<CursoModel>?> listaSemestreCursos;

    // 1. Obtener etiquetas de semestres
    elemEtiqSeme = document
        .getElementsByTagName(tagFieldset)[0]
        .getElementsByClassName(classTextCenter);
    etiquetasSemestres = [];
    elemEtiqSeme.forEach((Element e) {
      etiquetasSemestres.add(e.text.trim());
    });

    matricesDeInformacion = [];
    listaSemestreCursos = [];
    elemTablaSeme = document
        .getElementsByTagName(tagFieldset)[0]
        .getElementsByClassName(classKGridWidget);
    elemTablaSeme.forEach((Element tablaMaestra) {
      List<List<Element>> matrizCrudo;
      List<List<dynamic>> matrizDeInformacion;

      // 2. Obtener matriz de informacion
      var elementosMatriz =
          tablaMaestra.getElementsByClassName(classKGridToolbar);
      if (elementosMatriz.length != 0) {
        // ... si existe
        // Obtener matriz cruda
        var elemTablaInformacion = elementosMatriz[0];
        var filas = elemTablaInformacion.getElementsByTagName(tagFilaTabla);
        matrizCrudo = [];
        filas.forEach((Element fila) {
          // debugPrint(fila.innerHtml);
          matrizCrudo.add(fila.getElementsByTagName(tagCasilleroTabla));
        });
        // Dar formato a la matriz
        matrizDeInformacion = [];

        matrizDeInformacion.add([]);
        matrizDeInformacion[0].add(double.parse(matrizCrudo[0][1].text));
        matrizDeInformacion[0].add(double.parse(matrizCrudo[0][3].text));
        matrizDeInformacion[0].add(double.parse(matrizCrudo[0][5].text));
        matrizDeInformacion[0].add(double.parse(matrizCrudo[0][7].text));
        matrizDeInformacion[0].add(int.parse(matrizCrudo[0][9].text));

        matrizDeInformacion.add([]);
        matrizDeInformacion[1].add(int.parse(matrizCrudo[1][1].text));
        matrizDeInformacion[1].add(int.parse(matrizCrudo[1][3].text));
        matrizDeInformacion[1].add(int.parse(matrizCrudo[1][5].text));
        matrizDeInformacion[1].add(int.parse(matrizCrudo[1][7].text));
        matrizDeInformacion[1].add(int.parse(matrizCrudo[1][9].text));

        matrizDeInformacion.add([]);
        matrizDeInformacion[2]
            .add(double.parse(matrizCrudo[2][1].text).toInt());
        matrizDeInformacion[2]
            .add(double.parse(matrizCrudo[2][3].text).toInt());
        matrizDeInformacion[2]
            .add(double.parse(matrizCrudo[2][5].text).toInt());
        matrizDeInformacion[2]
            .add(double.parse(matrizCrudo[2][7].text).toInt());
        matrizDeInformacion[2]
            .add(double.parse(matrizCrudo[2][9].text).toInt());

        // for(int i = 0; i < matrizDeInformacion.length; i++){
        //   for(int j = 0; j < matrizDeInformacion[i].length; j++){
        //     _print('matrizDeInformacion[$i][$j] = ${matrizDeInformacion[i][j]}');
        //   }
        // }
        matricesDeInformacion.add(matrizDeInformacion);
      } else {
        matricesDeInformacion.add(null);
      }

      // 2. Obtener cursos
      var elementosCursos =
          tablaMaestra.getElementsByClassName(classKGridContent);
      if (elementosCursos.length != 0) {
        List<CursoModel> cursos;
        // CursoModel curso;

        var tablaCursosBody =
            elementosCursos[0].getElementsByTagName(tagCuerpoTabla)[0];
        List<Element> cursoElements =
            tablaCursosBody.getElementsByTagName(tagFilaTabla);
        cursos = [];
        cursoElements.forEach((Element fila) {
          var casilleros = fila.getElementsByTagName(tagCasilleroTabla);
          var curso = CursoModel(casilleros[1].text, casilleros[0].text);
          curso.caracteristicas.add(CursoCaracteristica(
              CursoCaracteristica.tipo, casilleros[2].text));
          curso.caracteristicas.add(CursoCaracteristica(
              CursoCaracteristica.creditos, casilleros[3].text));
          curso.caracteristicas.add(CursoCaracteristica(
              CursoCaracteristica.nota, casilleros[4].text));
          cursos.add(curso);
        });

        listaSemestreCursos.add(cursos);
      } else {
        listaSemestreCursos.add(null);
      }
    });

    // Generar modelo
    modelo = HistorialModel();
    var ciclo;
    for (int i = 0; i < etiquetasSemestres.length; i++) {
      ciclo = CicloHistorialModel(
        etiqueta: etiquetasSemestres[i],
        matrizInformacion: matricesDeInformacion[i],
      );
      ciclo.cursos = listaSemestreCursos[i];
      if (ciclo.matrizInformacion != null) {
        modelo.ciclosRegulares.add(ciclo);
      }
      modelo.ciclos.add(ciclo);
    }

    return modelo;
  }

  // Informe Académico
  static InformeModel informeGenerarModelo(Document document) {
    String alumno,
        facultad,
        semestreIngreso,
        promocion,
        semestrePlanEstudios,
        ppUltimo,
        ppAcumulado,
        ppAprobado,
        creditosAprobados;
    List<List<String>> requisitos;
    List<String> filaCreditosTabla;
    String fechaActualizacionInforme;
    List<Element> datos, creditosTabla, casillerosTabla;
    int i;

    // debugPrint(':v ->>>>>>>>>>\n${document.outerHtml}');
    alumno = document
        .getElementById('Informe')!
        .getElementsByTagName(tagHeading4)[0]
        .text;
    facultad = document
        .getElementById('Informe')!
        .getElementsByTagName(tagParrafo)[0]
        .text
        .trim();
    facultad = facultad.substring(25, facultad.length - 35);

    datos = document
        .getElementById('Informe')!
        .getElementsByTagName(tagCuerpoTabla)[0]
        .getElementsByTagName(tagFilaTabla);
    semestreIngreso = datos[0].getElementsByTagName(tagCasilleroTabla)[1].text;
    promocion = datos[1].getElementsByTagName(tagCasilleroTabla)[1].text;
    semestrePlanEstudios =
        datos[2].getElementsByTagName(tagCasilleroTabla)[1].text;
    ppUltimo = datos[3].getElementsByTagName(tagCasilleroTabla)[1].text;
    ppAcumulado = datos[4].getElementsByTagName(tagCasilleroTabla)[1].text;
    ppAprobado = datos[5].getElementsByTagName(tagCasilleroTabla)[1].text;
    creditosAprobados =
        datos[6].getElementsByTagName(tagCasilleroTabla)[1].text;
    creditosAprobados = creditosAprobados.split(' ')[0].trim();

    creditosTabla = document
        .getElementsByTagName(tagCuerpoTabla)[1]
        .getElementsByTagName(tagFilaTabla);
    // requisitos = List<List<String>>();
    requisitos = [];
    creditosTabla.forEach((fila) {
      // _print('fila $fila');
      casillerosTabla = fila.getElementsByTagName(tagCasilleroTabla);
      filaCreditosTabla = [];
      for (i = 1; i < casillerosTabla.length; i++) {
        // _print('casillerosTabla[$i].text = ${casillerosTabla[i].text}');
        filaCreditosTabla.add(casillerosTabla[i].text.trim());
      }
      requisitos.add(filaCreditosTabla);
    });

    fechaActualizacionInforme = document
        .getElementsByTagName(tagFieldset)[0]
        .getElementsByTagName(tagHeading5)[0]
        .text
        .trim();

    return InformeModel(
      alumno: alumno,
      creditosAprobados: creditosAprobados,
      facultad: facultad,
      fechaActualizacionInforme: fechaActualizacionInforme,
      ppUltimo: ppUltimo,
      ppAcumulado: ppAcumulado,
      ppAprobado: ppAprobado,
      promocion: promocion,
      requisitos: requisitos,
      semestreIngreso: semestreIngreso,
      semestrePlanEstudios: semestrePlanEstudios,
    );
  }

  // Core
  static Element _obtenerTabla(Document document) {
    return document.getElementsByTagName(tagCuerpoTabla)[0];
  }

  static void _print(Object mensaje) {
    print("🔨:\t$mensaje");
  }

  // Otros
  static bool isNotasUrl(String url) {
    bool ban;

    ban = false;
    if (url.length == (Urls.NOTAS.length + 10)) {
      if (url.substring(0, url.length - 10) == Urls.NOTAS) {
        ban = true;
      }
    }

    return ban;
  }
}
