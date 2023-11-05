class ChessGame {
  int? gameID;
  final String event;
  final String site;
  final String date;
  final String round;
  final String white;
  final String black;
  final String result;
  final String currentPosition;
  final String timeZone;
  final String eco;
  final String ecoUrl;
  final String utcDate;
  final String utcTime;
  final String whiteElo;
  final String blackElo;
  final String timeControl;
  final String termination;
  final String startTime;
  final String endDate;
  final String endTime;
  final String link;
  final String moves;
  final String rawPGN;
  final String timeClass = '';
  final String wAccuracy = '';
  final String bAccuracy = '';
  final String wCPL = '';
  final String bCPL = '';

  ChessGame({
    this.gameID,
    required this.event,
    required this.site,
    required this.date,
    required this.round,
    required this.white,
    required this.black,
    required this.result,
    required this.currentPosition,
    required this.timeZone,
    required this.eco,
    required this.ecoUrl,
    required this.utcDate,
    required this.utcTime,
    required this.whiteElo,
    required this.blackElo,
    required this.timeControl,
    required this.termination,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.link,
    required this.moves,
    required this.rawPGN,
  });

  factory ChessGame.fromJson(Map<String, dynamic> json) => ChessGame(
        gameID: json['GameID'],
        event: json['Event'],
        site: json['Site'],
        date: json['Date'],
        round: json['Round'],
        white: json['White'],
        black: json['Black'],
        result: json['Result'],
        currentPosition: json['CurrentPosition'],
        timeZone: json['Timezone'],
        eco: json['ECO'],
        ecoUrl: json['ECOUrl'],
        utcDate: json['UTCDate'],
        utcTime: json['UTCTime'],
        whiteElo: json['WhiteElo'],
        blackElo: json['BlackElo'],
        timeControl: json['TimeControl'],
        termination: json['Termination'],
        startTime: json['StartTime'],
        endDate: json['EndDate'],
        endTime: json['EndTime'],
        link: json['Link'],
        moves: json['Moves'],
        rawPGN: json['RawPGN'],
      );

  Map<String, dynamic> toJson() => {
        'GameID': gameID,
        'Event': event,
        'Site': site,
        'Date': date,
        'Round': round,
        'White': white,
        'Black': black,
        'Result': result,
        'CurrentPosition': currentPosition,
        'Timezone': timeZone,
        'ECO': eco,
        'ECOUrl': ecoUrl,
        'UTCDate': utcDate,
        'UTCTime': utcTime,
        'WhiteElo': whiteElo,
        'BlackElo': blackElo,
        'TimeControl': timeControl,
        'Termination': termination,
        'StartTime': startTime,
        'EndDate': endDate,
        'EndTime': endTime,
        'Link': link,
        'Moves': moves,
        'RawPGN': rawPGN,
      };
}
