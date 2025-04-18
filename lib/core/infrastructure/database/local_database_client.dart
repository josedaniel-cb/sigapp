import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer' as developer;

@singleton
class LocalDatabaseClient {
  static const String _databaseName = 'sigapp.db';
  static const int _databaseVersion = 1;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Utilizamos getApplicationDocumentsDirectory para garantizar que la base de datos
    // se almacene en una ubicación persistente entre sesiones
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    // Registrar la ubicación de la base de datos para depuración
    developer.log('Ubicación de la base de datos: $path', name: 'sqflite');

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: (db) async {
        // Habilitar foreign keys
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create course tracking table
    await db.execute('''
      CREATE TABLE course_tracking (
        id TEXT PRIMARY KEY,
        course_name TEXT NOT NULL
      )
    ''');

    // Create grade categories table
    await db.execute('''
      CREATE TABLE grade_categories (
        id TEXT PRIMARY KEY,
        course_tracking_id TEXT NOT NULL,
        name TEXT NOT NULL,
        weight REAL NOT NULL,
        FOREIGN KEY (course_tracking_id) REFERENCES course_tracking (id) ON DELETE CASCADE
      )
    ''');

    // Create individual grades table (con la columna 'enabled' incluida en la creación inicial)
    await db.execute('''
      CREATE TABLE grades (
        id TEXT PRIMARY KEY,
        category_id TEXT NOT NULL,
        name TEXT NOT NULL,
        score REAL NOT NULL,
        enabled INTEGER NOT NULL DEFAULT 1,
        FOREIGN KEY (category_id) REFERENCES grade_categories (id) ON DELETE CASCADE
      )
    ''');

    developer.log('Base de datos creada correctamente', name: 'sqflite');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Este método queda vacío por ahora, ya que estamos en la versión inicial
    // Si en el futuro necesitas hacer migraciones, se implementarían aquí
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
