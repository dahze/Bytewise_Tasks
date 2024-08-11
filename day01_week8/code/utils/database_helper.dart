import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/library_movie.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'library.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE library (
            id INTEGER PRIMARY KEY,
            title TEXT,
            posterPath TEXT,
            rating REAL
          )
        ''');
      },
    );
  }

  Future<void> addMovie(LibraryMovie movie) async {
    final db = await database;
    await db.insert(
      'library',
      movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeMovie(int id) async {
    final db = await database;
    await db.delete(
      'library',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<LibraryMovie>> getAllMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('library');

    return List.generate(maps.length, (i) {
      return LibraryMovie.fromMap(maps[i]);
    });
  }

  Future<bool> isMovieInLibrary(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'library',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }
}
