import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'get_program_curriculum_course.freezed.dart';
part 'get_program_curriculum_course.g.dart';

/// Model for
/// ```json
// {
//     "results": [
//         {
//             "ExtensionData": {},
//             "Ciclo": "I",
//             "CodCurso": "ED1292",
//             "Creditos": 2,
//             "DescripCurso": "ACTIVIDAD DEPORTIVA",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 64,
//             "HorasTeoria": 0,
//             "NroCiclo": 1,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "I",
//             "CodCurso": "SI1447",
//             "Creditos": 4,
//             "DescripCurso": "ALGORITMOS",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 1,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "I",
//             "CodCurso": "ED1331",
//             "Creditos": 3,
//             "DescripCurso": "COMUNICACION",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 32,
//             "NroCiclo": 1,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "I",
//             "CodCurso": "MA1470",
//             "Creditos": 4,
//             "DescripCurso": "GEOMETRIA ANALITICA",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 1,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "I",
//             "CodCurso": "SI1358",
//             "Creditos": 3,
//             "DescripCurso": "HERRAMIENTAS OFIMATICAS PARA LA VIDA UNIVERSITARIA",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 64,
//             "HorasTeoria": 16,
//             "NroCiclo": 1,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "I",
//             "CodCurso": "SI1216",
//             "Creditos": 2,
//             "DescripCurso": "INTRODUCCION A LA INGENIERIA INFORMATICA",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 0,
//             "HorasTeoria": 32,
//             "NroCiclo": 1,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "I",
//             "CodCurso": "MA1408",
//             "Creditos": 4,
//             "DescripCurso": "MATEMATICA BASICA",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 1,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "I",
//             "CodCurso": "ED1297",
//             "Creditos": 2,
//             "DescripCurso": "METODOLOGIA DE LOS ESTUDIOS SUPERIORES UNIVERSITARIOS",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 16,
//             "NroCiclo": 1,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "II",
//             "CodCurso": "CB1324",
//             "Creditos": 3,
//             "DescripCurso": "BIOLOGIA Y EDUCACION AMBIENTAL",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 32,
//             "NroCiclo": 2,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "II",
//             "CodCurso": "MA1435",
//             "Creditos": 4,
//             "DescripCurso": "CALCULO I",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 2,
//             "HorasTeoria": 3,
//             "NroCiclo": 2,
//             "ResumenRequisitos": "MA1408 - MA1470"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "II",
//             "CodCurso": "FI1363",
//             "Creditos": 3,
//             "DescripCurso": "CONCEPCION FISICA DEL UNIVERSO",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 32,
//             "NroCiclo": 2,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "II",
//             "CodCurso": "SI1445",
//             "Creditos": 4,
//             "DescripCurso": "ESTRUCTURAS DISCRETAS",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 2,
//             "ResumenRequisitos": "SI1447"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "II",
//             "CodCurso": "CS1286",
//             "Creditos": 2,
//             "DescripCurso": "FILOSOFIA Y ETICA",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 16,
//             "NroCiclo": 2,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "II",
//             "CodCurso": "SI1435",
//             "Creditos": 4,
//             "DescripCurso": "PROGRAMACION I",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 2,
//             "ResumenRequisitos": "SI1216 - SI1447"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "II",
//             "CodCurso": "QU1363",
//             "Creditos": 3,
//             "DescripCurso": "QUIMICA GENERAL",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 32,
//             "NroCiclo": 2,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "III",
//             "CodCurso": "CA2337",
//             "Creditos": 3,
//             "DescripCurso": "ADMINISTRACION",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 0,
//             "HorasTeoria": 48,
//             "NroCiclo": 3,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "III",
//             "CodCurso": "MA2441",
//             "Creditos": 4,
//             "DescripCurso": "CALCULO II",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 3,
//             "ResumenRequisitos": "MA1435"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "III",
//             "CodCurso": "EC2201",
//             "Creditos": 2,
//             "DescripCurso": "ECONOMIA GENERAL",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 16,
//             "NroCiclo": 3,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "III",
//             "CodCurso": "FI2410",
//             "Creditos": 4,
//             "DescripCurso": "FISICA I",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 3,
//             "ResumenRequisitos": "FI1363 - MA1435"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "III",
//             "CodCurso": "SI2422",
//             "Creditos": 4,
//             "DescripCurso": "PROGRAMACION II",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 3,
//             "ResumenRequisitos": "SI1435"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "III",
//             "CodCurso": "CS2397",
//             "Creditos": 3,
//             "DescripCurso": "REALIDAD NACIONAL Y REGIONAL",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 32,
//             "NroCiclo": 3,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "III",
//             "CodCurso": "CS2258",
//             "Creditos": 2,
//             "DescripCurso": "SOCIOLOGIA",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 16,
//             "NroCiclo": 3,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "III",
//             "CodCurso": "ED2278",
//             "Creditos": 2,
//             "DescripCurso": "TALLER DE ARTE",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 64,
//             "HorasTeoria": 0,
//             "NroCiclo": 3,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "IV",
//             "CodCurso": "CA2101",
//             "Creditos": 1,
//             "DescripCurso": "ACTIVIDAD DE RESPONSABILIDAD SOCIAL UNIVERSITARIA",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 0,
//             "NroCiclo": 4,
//             "ResumenRequisitos": "CS2258"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "IV",
//             "CodCurso": "MA2333",
//             "Creditos": 3,
//             "DescripCurso": "ALGEBRA LINEAL",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 32,
//             "NroCiclo": 4,
//             "ResumenRequisitos": "MA1435"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "IV",
//             "CodCurso": "ES2300",
//             "Creditos": 3,
//             "DescripCurso": "ESTADISTICA GENERAL",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 64,
//             "HorasTeoria": 16,
//             "NroCiclo": 4,
//             "ResumenRequisitos": "SI1358"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "IV",
//             "CodCurso": "SI2418",
//             "Creditos": 4,
//             "DescripCurso": "ESTRUCTURA DE DATOS",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 4,
//             "ResumenRequisitos": "SI1435 - SI1445"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "IV",
//             "CodCurso": "FI2411",
//             "Creditos": 4,
//             "DescripCurso": "FISICA II",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 4,
//             "ResumenRequisitos": "FI2410"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "IV",
//             "CodCurso": "SI2452",
//             "Creditos": 4,
//             "DescripCurso": "INGENIERIA DE PROCESOS DE NEGOCIOS",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 4,
//             "ResumenRequisitos": "CA2337"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "IV",
//             "CodCurso": "CO2201",
//             "Creditos": 2,
//             "DescripCurso": "INTRODUCCION A LA CONTABILIDAD",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 16,
//             "NroCiclo": 4,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "IV",
//             "CodCurso": "CS2259",
//             "Creditos": 2,
//             "DescripCurso": "PSICOLOGIA GENERAL",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 16,
//             "NroCiclo": 4,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "V",
//             "CodCurso": "SI3422",
//             "Creditos": 4,
//             "DescripCurso": "ANALISIS Y DISEÑO DE SISTEMAS I",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 5,
//             "ResumenRequisitos": "SI2452"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "V",
//             "CodCurso": "MA3412",
//             "Creditos": 4,
//             "DescripCurso": "CALCULO III",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 5,
//             "ResumenRequisitos": "MA2441"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "V",
//             "CodCurso": "FI3492",
//             "Creditos": 4,
//             "DescripCurso": "CIRCUITOS ELECTRICOS Y ELECTRONICOS",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 5,
//             "ResumenRequisitos": "FI2411"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "V",
//             "CodCurso": "ED3286",
//             "Creditos": 2,
//             "DescripCurso": "DISCAPACIDAD Y DERECHOS HUMANOS",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 16,
//             "NroCiclo": 5,
//             "ResumenRequisitos": "CS2397"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "V",
//             "CodCurso": "ED3283",
//             "Creditos": 2,
//             "DescripCurso": "INGLES I",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 16,
//             "NroCiclo": 5,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "V",
//             "CodCurso": "SI3421",
//             "Creditos": 4,
//             "DescripCurso": "MODELADO DE DATOS",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 5,
//             "ResumenRequisitos": "SI2418"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "V",
//             "CodCurso": "SI3331",
//             "Creditos": 3,
//             "DescripCurso": "APLICACIONES AVANZADAS CON HOJAS DE CALCULO",
//             "FlagTipoCurso": "E",
//             "HorasPractica": 64,
//             "HorasTeoria": 16,
//             "NroCiclo": 5,
//             "ResumenRequisitos": "SI1447"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "V",
//             "CodCurso": "SI3334",
//             "Creditos": 3,
//             "DescripCurso": "INTRODUCCION A LOS ENTORNOS OPERATIVOS",
//             "FlagTipoCurso": "E",
//             "HorasPractica": 64,
//             "HorasTeoria": 16,
//             "NroCiclo": 5,
//             "ResumenRequisitos": "SI1216"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VI",
//             "CodCurso": "SI3423",
//             "Creditos": 4,
//             "DescripCurso": "ANALISIS Y DISEÑO DE SISTEMAS II",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 6,
//             "ResumenRequisitos": "SI3422"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VI",
//             "CodCurso": "SI3400",
//             "Creditos": 4,
//             "DescripCurso": "ARQUITECTURA DE COMPUTADORES",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 6,
//             "ResumenRequisitos": "FI3492"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VI",
//             "CodCurso": "SI3420",
//             "Creditos": 4,
//             "DescripCurso": "BASE DE DATOS",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 6,
//             "ResumenRequisitos": "SI3421"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VI",
//             "CodCurso": "ED3287",
//             "Creditos": 2,
//             "DescripCurso": "DEFENSA NACIONAL",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 16,
//             "NroCiclo": 6,
//             "ResumenRequisitos": "CS2397"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VI",
//             "CodCurso": "ES3336",
//             "Creditos": 3,
//             "DescripCurso": "INFERENCIA Y PROBABILIDADES",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 32,
//             "NroCiclo": 6,
//             "ResumenRequisitos": "ES2300"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VI",
//             "CodCurso": "ED3284",
//             "Creditos": 2,
//             "DescripCurso": "INGLES II",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 16,
//             "NroCiclo": 6,
//             "ResumenRequisitos": "ED3283"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VI",
//             "CodCurso": "ED3285",
//             "Creditos": 2,
//             "DescripCurso": "TALLER DE REDACCION CIENTIFICA",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 64,
//             "HorasTeoria": 0,
//             "NroCiclo": 6,
//             "ResumenRequisitos": "ED1331"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VI",
//             "CodCurso": "SI3337",
//             "Creditos": 3,
//             "DescripCurso": "ANALISIS DE ALGORITMOS",
//             "FlagTipoCurso": "E",
//             "HorasPractica": 64,
//             "HorasTeoria": 16,
//             "NroCiclo": 6,
//             "ResumenRequisitos": "SI2422"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VI",
//             "CodCurso": "SI3336",
//             "Creditos": 3,
//             "DescripCurso": "GRAFICOS POR COMPUTADORAS",
//             "FlagTipoCurso": "E",
//             "HorasPractica": 64,
//             "HorasTeoria": 16,
//             "NroCiclo": 6,
//             "ResumenRequisitos": "SI2422"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VI",
//             "CodCurso": "AA3303",
//             "Creditos": 3,
//             "DescripCurso": "LOGISTICA EMPRESARIAL",
//             "FlagTipoCurso": "E",
//             "HorasPractica": 0,
//             "HorasTeoria": 48,
//             "NroCiclo": 6,
//             "ResumenRequisitos": "CA2337"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VI",
//             "CodCurso": "SI3335",
//             "Creditos": 3,
//             "DescripCurso": "TEORIA DE COMPILADORES",
//             "FlagTipoCurso": "E",
//             "HorasPractica": 0,
//             "HorasTeoria": 48,
//             "NroCiclo": 6,
//             "ResumenRequisitos": "SI2418"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VII",
//             "CodCurso": "IO4447",
//             "Creditos": 4,
//             "DescripCurso": "DISEÑOS DE INVESTIGACION PARA INGENIERIA",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 7,
//             "ResumenRequisitos": "ED3285 - ES3336"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VII",
//             "CodCurso": "CA4221",
//             "Creditos": 2,
//             "DescripCurso": "EMPRENDEDURISMO",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 16,
//             "NroCiclo": 7,
//             "ResumenRequisitos": "---"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VII",
//             "CodCurso": "IO4448",
//             "Creditos": 4,
//             "DescripCurso": "INVESTIGACION DE OPERACIONES",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 7,
//             "ResumenRequisitos": "ES3336 - MA2333"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VII",
//             "CodCurso": "SI4386",
//             "Creditos": 3,
//             "DescripCurso": "PROGRAMACION VISUAL",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 64,
//             "HorasTeoria": 16,
//             "NroCiclo": 7,
//             "ResumenRequisitos": "SI2422"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VII",
//             "CodCurso": "SI4489",
//             "Creditos": 4,
//             "DescripCurso": "SISTEMA DE ADMINISTRACION DE BASE DE DATOS",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 7,
//             "ResumenRequisitos": "SI3420"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VII",
//             "CodCurso": "SI4490",
//             "Creditos": 4,
//             "DescripCurso": "SISTEMAS OPERATIVOS",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 7,
//             "ResumenRequisitos": "SI2418 - SI3400"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VII",
//             "CodCurso": "SI4388",
//             "Creditos": 3,
//             "DescripCurso": "METODOS DE ACCESO",
//             "FlagTipoCurso": "E",
//             "HorasPractica": 64,
//             "HorasTeoria": 16,
//             "NroCiclo": 7,
//             "ResumenRequisitos": "SI3421"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VII",
//             "CodCurso": "IO4334",
//             "Creditos": 3,
//             "DescripCurso": "METODOS NUMERICOS",
//             "FlagTipoCurso": "E",
//             "HorasPractica": 32,
//             "HorasTeoria": 32,
//             "NroCiclo": 7,
//             "ResumenRequisitos": "MA3412"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VII",
//             "CodCurso": "SI4387",
//             "Creditos": 3,
//             "DescripCurso": "PROGRAMACION MULTIMEDIA",
//             "FlagTipoCurso": "E",
//             "HorasPractica": 64,
//             "HorasTeoria": 16,
//             "NroCiclo": 7,
//             "ResumenRequisitos": "SI2422"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VII",
//             "CodCurso": "IO4332",
//             "Creditos": 3,
//             "DescripCurso": "SIMULACION Y JUEGOS",
//             "FlagTipoCurso": "E",
//             "HorasPractica": 32,
//             "HorasTeoria": 32,
//             "NroCiclo": 7,
//             "ResumenRequisitos": "SI2422"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VIII",
//             "CodCurso": "DP4331",
//             "Creditos": 3,
//             "DescripCurso": "DERECHO INFORMATICO",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 0,
//             "HorasTeoria": 48,
//             "NroCiclo": 8,
//             "ResumenRequisitos": "CS1286 - ED3286"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VIII",
//             "CodCurso": "SI4488",
//             "Creditos": 4,
//             "DescripCurso": "INGENIERIA DE SOFTWARE",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 8,
//             "ResumenRequisitos": "SI3423 - SI4489"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VIII",
//             "CodCurso": "EM4461",
//             "Creditos": 4,
//             "DescripCurso": "MICROECONOMIA",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 8,
//             "ResumenRequisitos": "EC2201"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VIII",
//             "CodCurso": "SI4360",
//             "Creditos": 3,
//             "DescripCurso": "ORGANIZAC. Y ADMINIST. INFORMATICA",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 8,
//             "ResumenRequisitos": "SI3423"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VIII",
//             "CodCurso": "SI4491",
//             "Creditos": 4,
//             "DescripCurso": "REDES",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 8,
//             "ResumenRequisitos": "SI4490"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "VIII",
//             "CodCurso": "SI4465",
//             "Creditos": 4,
//             "DescripCurso": "SISTEMAS DE INFORMACION GERENCIAL",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 8,
//             "ResumenRequisitos": "SI4489"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "IX",
//             "CodCurso": "SI5364",
//             "Creditos": 3,
//             "DescripCurso": "ELABORACION DE PROYECTOS INFORMATICOS",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 64,
//             "HorasTeoria": 16,
//             "NroCiclo": 9,
//             "ResumenRequisitos": "SI4360"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "IX",
//             "CodCurso": "IO5365",
//             "Creditos": 3,
//             "DescripCurso": "METODOLOGIA PARA EL PROYECTO DE INVESTIGACION",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 64,
//             "HorasTeoria": 16,
//             "NroCiclo": 9,
//             "ResumenRequisitos": "IO4447 - SI4488"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "IX",
//             "CodCurso": "SI5497",
//             "Creditos": 4,
//             "DescripCurso": "PROCESOS DE DESARROLLO DE SOFTWARE",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 9,
//             "ResumenRequisitos": "SI3423"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "IX",
//             "CodCurso": "SI5496",
//             "Creditos": 4,
//             "DescripCurso": "SEGURIDAD DE LA INFORMACION",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 9,
//             "ResumenRequisitos": "SI4491"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "IX",
//             "CodCurso": "SI5441",
//             "Creditos": 4,
//             "DescripCurso": "SISTEMAS DE CONTROL Y AUDITORIA INFORMATICA",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 9,
//             "ResumenRequisitos": "DP4331 - SI4488"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "IX",
//             "CodCurso": "SI5365",
//             "Creditos": 3,
//             "DescripCurso": "TECNOLOGIA Y DESARROLLO WEB",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 64,
//             "HorasTeoria": 16,
//             "NroCiclo": 9,
//             "ResumenRequisitos": "SI4488"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "IX",
//             "CodCurso": "SI5370",
//             "Creditos": 3,
//             "DescripCurso": "MICROCOMPUTADORAS",
//             "FlagTipoCurso": "E",
//             "HorasPractica": 64,
//             "HorasTeoria": 16,
//             "NroCiclo": 9,
//             "ResumenRequisitos": "SI3400"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "IX",
//             "CodCurso": "II5314",
//             "Creditos": 3,
//             "DescripCurso": "PROGRAMACION DE MICROBOTS",
//             "FlagTipoCurso": "E",
//             "HorasPractica": 32,
//             "HorasTeoria": 32,
//             "NroCiclo": 9,
//             "ResumenRequisitos": "SI3400"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "IX",
//             "CodCurso": "SI5369",
//             "Creditos": 3,
//             "DescripCurso": "TRATAMIENTO DIGITAL DE IMAGENES Y AUDIO",
//             "FlagTipoCurso": "E",
//             "HorasPractica": 64,
//             "HorasTeoria": 16,
//             "NroCiclo": 9,
//             "ResumenRequisitos": "MA3412 - SI2422"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "X",
//             "CodCurso": "CO5397",
//             "Creditos": 3,
//             "DescripCurso": "CONTABILIDAD DE COSTOS Y PRESUPUESTOS",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 0,
//             "HorasTeoria": 48,
//             "NroCiclo": 10,
//             "ResumenRequisitos": "CO2201 - EM4461"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "X",
//             "CodCurso": "SI5367",
//             "Creditos": 3,
//             "DescripCurso": "DESARROLLO DE LA INVESTIGACION INFORMATICA",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 64,
//             "HorasTeoria": 16,
//             "NroCiclo": 10,
//             "ResumenRequisitos": "IO5365"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "X",
//             "CodCurso": "SI5411",
//             "Creditos": 4,
//             "DescripCurso": "GESTION EN INFORMATICA",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 10,
//             "ResumenRequisitos": "SI5364"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "X",
//             "CodCurso": "SI5499",
//             "Creditos": 4,
//             "DescripCurso": "INTELIGENCIA DE NEGOCIOS",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 10,
//             "ResumenRequisitos": "SI4465"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "X",
//             "CodCurso": "SI5498",
//             "Creditos": 4,
//             "DescripCurso": "SISTEMAS ORIENTADOS A SERVICIOS",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 32,
//             "HorasTeoria": 48,
//             "NroCiclo": 10,
//             "ResumenRequisitos": "SI5365"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "X",
//             "CodCurso": "SI5368",
//             "Creditos": 3,
//             "DescripCurso": "TECNOLOGIA Y DESARROLLO MOVIL",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 64,
//             "HorasTeoria": 16,
//             "NroCiclo": 10,
//             "ResumenRequisitos": "SI5365"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "X",
//             "CodCurso": "SI5373",
//             "Creditos": 3,
//             "DescripCurso": "TRABAJO DE INVESTIGACION",
//             "FlagTipoCurso": "O",
//             "HorasPractica": 64,
//             "HorasTeoria": 16,
//             "NroCiclo": 10,
//             "ResumenRequisitos": "IO5365"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "X",
//             "CodCurso": "SI5361",
//             "Creditos": 3,
//             "DescripCurso": "INTRODUCION A LA INTELIGENCIA ARTIFICIAL",
//             "FlagTipoCurso": "E",
//             "HorasPractica": 2,
//             "HorasTeoria": 3,
//             "NroCiclo": 10,
//             "ResumenRequisitos": "SI2418"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "X",
//             "CodCurso": "II5345",
//             "Creditos": 3,
//             "DescripCurso": "PLANEAMIENTO Y CONTROL DE PRODUCCION",
//             "FlagTipoCurso": "E",
//             "HorasPractica": 0,
//             "HorasTeoria": 48,
//             "NroCiclo": 10,
//             "ResumenRequisitos": "IO4448"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "X",
//             "CodCurso": "II5344",
//             "Creditos": 3,
//             "DescripCurso": "SISTEMAS SCADA",
//             "FlagTipoCurso": "E",
//             "HorasPractica": 32,
//             "HorasTeoria": 32,
//             "NroCiclo": 10,
//             "ResumenRequisitos": "SI3400"
//         },
//         {
//             "ExtensionData": {},
//             "Ciclo": "X",
//             "CodCurso": "SI5371",
//             "Creditos": 3,
//             "DescripCurso": "TALLER DE SERVIDORES",
//             "FlagTipoCurso": "E",
//             "HorasPractica": 64,
//             "HorasTeoria": 16,
//             "NroCiclo": 10,
//             "ResumenRequisitos": "SI4491"
//         }
//     ],
//     "total": 86
// }
/// ```
@freezed
abstract class GetProgramCurriculumCourseModel with _$GetProgramCurriculumCourseModel {
  const factory GetProgramCurriculumCourseModel({
    required String Ciclo,
    required String CodCurso,
    required int Creditos,
    required String DescripCurso,
    required String FlagTipoCurso,
    required int HorasPractica,
    required int HorasTeoria,
    required int NroCiclo,
    required String ResumenRequisitos,
  }) = _GetProgramCurriculumCourseModel;

  factory GetProgramCurriculumCourseModel.fromJson(Map<String, Object?> json) =>
      _$GetProgramCurriculumCourseModelFromJson(json);
}
