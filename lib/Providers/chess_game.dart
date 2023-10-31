class ChessGame {
  final DateTime date;
  final String whitePlayerName;
  final int whitePlayerELO;
  final String blackPlayerName;
  final int blackPlayerELO;
  final String result;
  final int moves;
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
    required this.moves,
    required this.timeControl,
    required this.timeClass,
    required this.wAccuracy,
    required this.bAccuracy,
    required this.wCPL,
    required this.bCPL,
  });
}
