import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import "package:flutter_application_1/models/popular_model.dart";

import '../models/post_model.dart';

class DatabaseHelper {
  static final nameDatabase = 'TDB';
  static final versionDB = 1;

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDatabase);

    return await openDatabase(
      pathDB,
      version: versionDB,
      onCreate: _createTables,
    );
  }

  _createTables(Database db, int version) async {
    String query =
        "CREATE TABLE tblPost( idPost INTEGER PRIMARY KEY, dscPost VARCHAR(200), datePost DATE )";

    String query2 = '''
      CREATE TABLE tblPopularFavorito (
        backdrop_path TEXT,
        id INTEGER,
        original_language TEXT,
        original_title TEXT,
        overview TEXT,
        popularity REAL,
        poster_path TEXT,
        release_date TEXT,
        title TEXT,
        vote_average REAL,
        vote_count INTEGER
      );
    ''';
    await db.execute(query);
    await db.execute(query2);
  }

  Future<int> INSERT(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion.insert(tblName, data);
  }

  Future<int> UPDATE(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion.update(tblName, data,
        where: 'IdPost = ?', whereArgs: [data['idPost']]);
  }

  Future<int> DELETE(String tblName, int idPost) async {
    var conexion = await database;
    return conexion.delete(tblName, where: 'IdPost = ?', whereArgs: [idPost]);
  }

  Future<List<PostModel>> GETALLPOST() async {
    var conexion = await database;
    var result = await conexion.query('tblPost');

    return result.map((post) => PostModel.fromMap(post)).toList();
  }

  /// Para favoritos de peliculas
  Future<List<PopularModel>> GETALLpopular() async {
    var conexion = await database;
    var result = await conexion.query('tblPopularFavorito');
    return result.map((event) => PopularModel.fromMap(event)).toList();
  }

  Future<int> DELETEpopular(String tblName, int id_popular) async {
    var conexion = await database;
    return conexion.delete(tblName, where: 'id=?', whereArgs: [id_popular]);
  }

  Future<bool> GETONEpopular(int id_popular) async {
    var conexion = await database;
    var result =
        await conexion.query('tblPopularFavorito', where: 'id=$id_popular');
    if (result.isNotEmpty) {
      return true;
    }
    return false;
  }
}
