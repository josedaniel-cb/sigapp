
class InformeModel{
  String alumno;

  String facultad;
  String semestreIngreso;
  String promocion;
  String semestrePlanEstudios;
  String ppUltimo;
  String ppAcumulado;
  String ppAprobado;
  String creditosAprobados;

  List<List<String>> requisitos;

  String fechaActualizacionInforme;

  InformeModel({
    required this.alumno,
    required this.facultad,
    required this.semestreIngreso,
    required this.promocion,
    required this.semestrePlanEstudios,
    required this.ppUltimo,
    required this.ppAcumulado,
    required this.ppAprobado,
    required this.creditosAprobados,
    required this.requisitos,
    required this.fechaActualizacionInforme,
  });

  static List<String> titulos = [
    'Semestre de Ingreso',
    'Pertenece a la Promoción',
    'Su Plan de Estudios correspondiente es',
    'Su último Promedio Ponderado Semestral es',
    'Su Promedio Ponderado Acumulado es ',
    'Su Promedio Ponderado Aprobado es',
    'Tiene aprobados en su historial un total de:',
  ];

  String contenidoAt(int i){
    switch(i){
      case 0:
        return semestreIngreso; 
        break;
      case 1:
        return promocion; 
        break;
      case 2:
        return semestrePlanEstudios; 
        break;
      case 3:
        return ppUltimo; 
        break;
      case 4:
        return ppAcumulado; 
        break;
      case 5:
        return ppAprobado; 
        break;
      case 6:
        return '$creditosAprobados créditos'; 
        break;
      default:
        return 'kha';
    }
  }
}