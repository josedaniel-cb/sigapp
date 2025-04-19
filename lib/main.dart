import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sigapp/core/infrastructure/ui/app.dart';
import 'package:sigapp/core/injection/get_it.dart';
// import 'package:sigapp/core/infrastructure/database/database_service.dart';
// import 'dart:developer' as developer;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cargar variables de entorno
  await dotenv.load(fileName: '.env');

  await configureDependencies();

  // // Inicializar y verificar la base de datos antes de iniciar la app
  // final databaseClient = getIt<LocalDatabaseClient>();
  // try {
  //   // Verificar la integridad de la base de datos
  //   final hasIntegrity = await databaseClient.checkDatabaseIntegrity();
  //   developer.log(
  //       'Verificación de integridad de base de datos: ${hasIntegrity ? 'OK' : 'Falló'}',
  //       name: 'App Initialization');
  // } catch (e) {
  //   developer.log('Error al verificar la base de datos: $e',
  //       name: 'App Initialization');
  // }

  // if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
  //   await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  // }

  runApp(const MyApp());
}
