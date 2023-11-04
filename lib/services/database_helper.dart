import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

import '../providers/chess_game.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "ChessGames.db";

  static Future<Database> _getDb() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            'CREATE TABLE ChessGames(date TEXT PRIMARY KEY, whitePlayerName TEXT NOT NULL, whitePlayerELO INTEGER NOT NULL, blackPlayerName TEXT NOT NULL, blackPlayerELO INTEGER NOT NULL, result TEXT NOT NULL,movesCount INTEGER NOT NULL , moves TEXT NOT NULL, timeControl TEXT NOT NULL, timeClass TEXT NOT NULL, wAccuracy TEXT NOT NULL, bAccuracy TEXT NOT NULL, wCPL TEXT NOT NULL, bCPL TEXT NOT NULL)'),
        version: _version);
  }

  static Future<int> addGame(ChessGame game) async {
    final db = await _getDb();
    return await db.insert('ChessGames', game.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateGame(ChessGame game) async {
    final db = await _getDb();
    return await db.update('ChessGames', game.toJson(),
        where: 'date = ?',
        whereArgs: [game.date],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteGame(ChessGame game) async {
    final db = await _getDb();
    return await db
        .delete('ChessGames', where: 'date = ?', whereArgs: [game.date]);
  }

  static Future<List<ChessGame>?> getAllGames() async {
    final db = await _getDb();

    final List<Map<String, dynamic>> maps = await db.query('ChessGames');

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => ChessGame.fromJson(maps[index]));
  }
}
