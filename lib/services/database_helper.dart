import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

import '../providers/chess_game.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "chessapp.db";

  static Future<Database> _getDb() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            'CREATE TABLE games (GameID INTEGER PRIMARY KEY AUTOINCREMENT, Event TEXT, Site TEXT, Date TEXT, Round TEXT, White TEXT, Black TEXT, Result TEXT, CurrentPosition TEXT, Timezone TEXT, ECO TEXT, ECOUrl TEXT, UTCDate TEXT, UTCTime TEXT, WhiteElo TEXT, BlackElo TEXT, TimeControl TEXT, Termination TEXT, StartTime TEXT, EndDate TEXT, EndTime TEXT, Link TEXT, Moves TEXT, RawPGN TEXT)'),
        version: _version);
  }

  static Future<int> addGame(ChessGame game) async {
    final db = await _getDb();
    return await db.insert('games', game.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateGame(ChessGame game) async {
    final db = await _getDb();
    return await db.update('games', game.toJson(),
        where: 'GameID = ?',
        whereArgs: [game.gameID],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteGame(ChessGame game) async {
    final db = await _getDb();
    return await db
        .delete('games', where: 'GameID = ?', whereArgs: [game.gameID]);
  }

  static Future<List<ChessGame>?> getAllGames() async {
    final db = await _getDb();

    final List<Map<String, dynamic>> maps = await db.query('games');

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => ChessGame.fromJson(maps[index]));
  }
}
