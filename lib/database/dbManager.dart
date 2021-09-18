import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yc_test/model/Movie.dart';

class DbMovieManager {
   Database? _database;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(
          join(await getDatabasesPath(), "movie.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE movie(id INTEGER PRIMARY KEY autoincrement, name "
              "TEXT, image TEXT,directorName TEXT, description TEXT)",

        );
      } );
    }
  }

  Future<int> insertMovie(MovieModel model) async {
    await openDb();
    return await _database!.insert('Movie', model.toMap());
  }

  Future<List<MovieModel>> getMovieList() async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database!.query('Movie');
    return List.generate(maps.length, (i) {
      return MovieModel(
          id: maps[i]['id'], name: maps[i]['name'], description:
      maps[i]['description'],image: maps[i]['image'],directorName: maps[i]['directorName']);
    });
  }

  Future<int> updateMovie(MovieModel model) async {
    await openDb();
    return await _database!.update('Movie', model.toMap(),
        where: "id = ?", whereArgs: [model.id]);
  }

  Future<void> deleteMovie(int id) async {
    await openDb();
    await _database!.delete(
        'Movie',
        where: "id = ?", whereArgs: [id]
    );
  }
}
