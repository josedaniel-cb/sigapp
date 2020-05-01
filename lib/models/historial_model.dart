import 'curso_model/curso_model.dart';

class HistorialModel{
  List<CicloHistorialModel> ciclos; // all
  List<CicloHistorialModel> ciclosRegulares; // graficables

  HistorialModel(){
    ciclos = List<CicloHistorialModel>();
    ciclosRegulares = List<CicloHistorialModel>();
  }

  /*
  PPS:	14.26	
  PPS Aprob:	14.26	
  PPA:	14.26	
  PPA Apr:	14.26	
  Cre Obl Llev:	19	
  Cre Obl Apr:	19
  Cre El Llev:	0	
  Cre Ele Apr:	0	
  Cre Obl Conv:	0	
  Cred Ele Conv:	0
  Total Cred Obl Llev:	19.00	
  Total Cred El Llev:	0	
  Total Cred Obl Aprob:	19.00	
  Total Cred El Aprob:	0	
  Total Cred Obl Conv:	0
  */

  // static const String PPS = 'PPS';
  // static const String PPS_Aprob = 'PPS Aprob';
  // static const String PPA = 'PPA';
  // static const String PPA_Apr = 'PPA Apr';
  // static const String Cre_Obl_Llev = 'Cre Obl Llev';
  // static const String Cre_Obl_Apr = 'Cre Obl Apr';
  // static const String Cre_El_Llev = 'Cre El Llev';
  // static const String Cre_El_Apr = 'Cre El Apr';
  // static const String Cre_Obl_Conv = 'Cre Obl Conv';
  // static const String Cred_El_Conv = 'Cred El Conv';
  // static const String Total_Cred_Obl_Llev = 'Total Cred Obl Llev';
  // static const String Total_Cred_El_Llev = 'Total Cred El Llev';
  // static const String Total_Cred_Obl_Aprob = 'Total Cred Obl Aprob';
  // static const String Total_Cred_El_Aprob = 'Total Cred El Aprob';
  // static const String Total_Cred_Obl_Conv = 'Total Cred Obl Conv';

  
}

class CicloHistorialModel{
  final String etiqueta;
  final List<List<dynamic>> matrizInformacion;
  List<CursoModel> cursos;

  CicloHistorialModel({this.etiqueta, this.matrizInformacion}){
    cursos = List<CursoModel>();
  }

  double get pps => matrizInformacion[0][0];
  double get ppsAprob => matrizInformacion[0][1];
  double get ppa => matrizInformacion[0][2];
  double get ppaAprob => matrizInformacion[0][3];

  int get creOblLlev => matrizInformacion[0][4];
  int get creOblApr => matrizInformacion[1][1];
  int get creElLlev => matrizInformacion[1][0];
  int get creElApr => matrizInformacion[1][2];
  int get creOblConv => matrizInformacion[1][3];
  int get creElConv => matrizInformacion[1][4];

  int get totalCredOblLlev => matrizInformacion[2][0];
  int get totalCredElLlev => matrizInformacion[2][1];
  int get totalCredOblAprob => matrizInformacion[2][2];
  int get totalCredElAprob => matrizInformacion[2][3];
  int get totalCredOblConv => matrizInformacion[2][4];

  static const String PPS = 'Promedio Ponderado Semestral';
  static const String PPS_Aprob = 'Promedio Ponderado Semestral Aprobado';
  static const String PPA = 'Promedio Ponderado Acumulado';
  static const String PPA_Aprob = 'Promedio Ponderado Acumulado Aprobado';

  static const String Cre_Obl_Llev = 'Créditos Obligatorios Llevados';
  static const String Cre_Obl_Apr = 'Créditos Obligatorios Aprobados';
  static const String Cre_Obl_Conv = 'Créditos Obligatorios Convalidados';
  static const String Cre_El_Llev = 'Créditos Electivos Llevados';
  static const String Cre_El_Apr = 'Créditos Electivos Aprobados';
  static const String Cre_El_Conv = 'Créditos Electivos Convalidados';
  
  static const String Total_Cred_Obl_Llev = 'Total Créditos Obligatorios Llevados';
  static const String Total_Cred_El_Llev = 'Total Créditos Electivos Llevados';
  static const String Total_Cred_Obl_Aprob = 'Total Créditos Obligatorios Aprobados';
  static const String Total_Cred_El_Aprob = 'Total Créditos Electivos Aprobados';
  static const String Total_Cred_Obl_Conv = 'Total Créditos Obligatorios Convalidados';
}