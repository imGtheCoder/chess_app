class ChessGame {
  final String date;
  final String whitePlayerName;
  final int whitePlayerELO;
  final String blackPlayerName;
  final int blackPlayerELO;
  final String result;
  final int movesCount;
  final String moves;
  final String timeControl;
  final String timeClass;
  final String wAccuracy;
  final String bAccuracy;
  final String wCPL;
  final String bCPL;

  ChessGame({
    required this.date,
    required this.whitePlayerName,
    required this.whitePlayerELO,
    required this.blackPlayerName,
    required this.blackPlayerELO,
    required this.result,
    required this.movesCount,
    required this.moves,
    required this.timeControl,
    required this.timeClass,
    required this.wAccuracy,
    required this.bAccuracy,
    required this.wCPL,
    required this.bCPL,
  });

  factory ChessGame.fromJson(Map<String, dynamic> json) => ChessGame(
        date: json['date'],
        whitePlayerName: json['whitePlayerName'],
        whitePlayerELO: json['whitePlayerELO'],
        blackPlayerName: json['blackPlayerName'],
        blackPlayerELO: json['blackPlayerELO'],
        result: json['result'],
        movesCount: json['movesCount'],
        moves: json['moves'],
        timeControl: json['timeControl'],
        timeClass: json['timeClass'],
        wAccuracy: json['wAccuracy'],
        bAccuracy: json['bAccuracy'],
        wCPL: json['wCPL'],
        bCPL: json['bCPL'],
      );

  Map<String, dynamic> toJson() => {
        'date': date,
        'whitePlayerName': whitePlayerName,
        'whitePlayerELO': whitePlayerELO,
        'blackPlayerName': blackPlayerName,
        'blackPlayerELO': blackPlayerELO,
        'result': result,
        'movesCount': movesCount,
        'moves': moves,
        'timeControl': timeControl,
        'timeClass': timeClass,
        'wAccuracy': wAccuracy,
        'bAccuracy': bAccuracy,
        'wCPL': wCPL,
        'bCPL': bCPL,
      };
}
