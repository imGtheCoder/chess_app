import 'package:chess_app/Screens/chessboard.dart';
import 'package:chess_app/Widgets/chess_board_builder.dart';
import 'package:chess_app/providers/chess_game.dart';
import 'package:chess_app/services/database_helper.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart' as cbb;
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const pageRoute = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  cbb.ChessBoardController controller = cbb.ChessBoardController();

  bool _expanded = false;
  String pickedText = 'No file selected yet';
  List<ChessGame> chessGames = [];

  List<String> moves = [];
  int i = 0;
  bool isGoingUp = true;
  String pgnstring = '';
  String lastMoveTXT = 'Choose a game';

  @override
  Widget build(BuildContext context) {
    DatabaseHelper.getAllGames().then((value) {
      value == null ? chessGames = [] : chessGames = value;
      
    });

    var bigDataTable = Padding(
      padding: const EdgeInsets.all(8.0),
      child: DataTable2(
          showCheckboxColumn: false,
          columnSpacing: 10,
          decoration: const BoxDecoration(color: Colors.white),
          sortColumnIndex: 1,
          sortAscending: true,
          columns: const <DataColumn>[
            DataColumn2(label: Text('Date'), size: ColumnSize.L),
            DataColumn2(
              label: Text('White Player'),
            ),
            DataColumn2(
              label: Text('(ELO)'),
            ),
            DataColumn2(label: Text('-'), size: ColumnSize.S),
            DataColumn2(
              label: Text('Black Player'),
            ),
            DataColumn2(
              label: Text('(ELO)'),
            ),
            DataColumn2(
              label: Text('Result'),
            ),
            DataColumn2(
              label: Text('Moves'),
            ),
            DataColumn2(
              label: Text('Time Ctrl'),
            ),
            DataColumn2(
              label: Text('Time Class'),
            ),
            DataColumn2(
              label: Text('W Accuracy'),
            ),
            DataColumn2(
              label: Text('B Accuracy'),
            ),
            DataColumn2(
              label: Text('White CPL'),
            ),
            DataColumn2(
              label: Text('Black CPL'),
            ),
          ],
          rows: chessGames
              .map((chessGame) => DataRow2(
                      onSelectChanged: (value) {
                        controller.loadPGN(chessGame.moves);
                        print(chessGame.moves);
                        moves = controller.getSan().cast<String>();
                        i = 0;
                        setState(() {
                          lastMoveTXT = 'Scroll using the arrows';
                        });
                      },
                      cells: [
                        DataCell(
                          // Text(DateFormat("yyyy.MM.dd")
                          //     .format(DateTime.parse(chessGame.date))),
                          Text(chessGame.date),
                        ),
                        DataCell(
                          Text(chessGame.white),
                        ),
                        DataCell(
                          Text(chessGame.whiteElo.toString()),
                        ),
                        const DataCell(
                          Text('-'),
                        ),
                        DataCell(
                          Text(chessGame.black),
                        ),
                        DataCell(
                          Text(chessGame.blackElo.toString()),
                        ),
                        DataCell(
                          Text(chessGame.result),
                        ),
                        DataCell(
                          Text(chessGame.moves.length.toString()),
                        ),
                        DataCell(
                          Text(chessGame.timeControl),
                        ),
                        DataCell(
                          Text(chessGame.timeClass),
                        ),
                        DataCell(
                          Text(chessGame.wAccuracy),
                        ),
                        DataCell(
                          Text(chessGame.bAccuracy),
                        ),
                        DataCell(
                          Text(chessGame.wCPL),
                        ),
                        DataCell(
                          Text(chessGame.bCPL),
                        ),
                      ]))
              .toList()),
    );

    var smallDataTable = DataTable2(
        showCheckboxColumn: false,
        columnSpacing: 10,
        decoration: const BoxDecoration(color: Colors.white),
        sortColumnIndex: 1,
        sortAscending: true,
        columns: const <DataColumn>[
          DataColumn2(
            label: Text('Date'),
          ),
          DataColumn2(label: Text('White Player'), size: ColumnSize.M),
          DataColumn2(label: Text('(ELO)'), size: ColumnSize.S),
          DataColumn2(
            label: Text('-'),
            size: ColumnSize.S,
          ),
          DataColumn2(label: Text('(ELO)'), size: ColumnSize.S),
          DataColumn2(label: Text('Black Player'), size: ColumnSize.M),
          DataColumn2(label: Text('Result'), size: ColumnSize.S),
        ],
        rows: chessGames
            .map((chessGame) => DataRow2(
                    onSelectChanged: (value) {
                      controller.loadPGN(chessGame.moves);
                      moves = controller.getSan().cast<String>();
                      i = 0;
                      setState(() {
                        lastMoveTXT = 'Scroll using the arrows';
                      });
                    },
                    cells: [
                      DataCell(
                        // Text(DateFormat("yyyy.MM.dd")
                        //     .format(DateTime.parse(chessGame.date))),
                        Text(chessGame.date)
                      ),
                      DataCell(
                        Text(chessGame.white),
                      ),
                      DataCell(
                        Text(chessGame.whiteElo.toString()),
                      ),
                      const DataCell(
                        Text('-'),
                      ),
                      DataCell(
                        Text(chessGame.blackElo.toString()),
                      ),
                      DataCell(
                        Text(chessGame.black),
                      ),
                      DataCell(
                        Text(chessGame.result),
                      ),
                    ]))
            .toList());

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(119, 153, 84, 1),
        title: const Text('Chess'),
      ),
      body: Container(
          color: const Color.fromRGBO(48, 46, 43, 1),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: _expanded
                ? Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 12,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            child: bigDataTable,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                              iconSize: 20,
                              onPressed: () {
                                setState(() {
                                  _expanded = !_expanded;
                                });
                              },
                              icon: const Icon(Icons.fullscreen_exit)),
                        ),
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.height - 40 - 97,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: cbb.ChessBoard(
                                controller: controller,
                                boardColor: cbb.BoardColor.orange,
                                boardOrientation: cbb.PlayerColor.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    pgnstring = '';

                                    if (isGoingUp) {
                                      i = i - 2;
                                    }
                                    if (i > moves.length - 1) {
                                      i = moves.length - 1;
                                    }
                                    if (i < 0) {
                                      i = 0;
                                    }
                                    for (int j = 0; j < i; j++) {
                                      pgnstring = pgnstring + moves[j] + ' ';
                                    }
                                    setState(() {
                                      if (i < 1) {
                                        lastMoveTXT = '0.';
                                      } else {
                                        lastMoveTXT = moves[i - 1];
                                      }
                                    });

                                    controller.loadPGN(pgnstring);

                                    i--;

                                    isGoingUp = false;
                                  },
                                  icon: const Icon(
                                    Icons.arrow_left,
                                    color: Colors.white54,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    pgnstring = '';
                                    if (!isGoingUp) {
                                      i = i + 2;
                                    }

                                    if (i < 0) {
                                      i = 0;
                                    }
                                    if (i > moves.length - 1) {
                                      i = moves.length - 1;
                                    }
                                    for (int j = 0; j < i; j++) {
                                      pgnstring = pgnstring + moves[j] + ' ';
                                    }
                                    setState(() {
                                      if (i < 1) {
                                        lastMoveTXT = '0.';
                                      } else {
                                        lastMoveTXT = moves[i - 1];
                                      }
                                    });

                                    controller.loadPGN(pgnstring);

                                    i++;

                                    isGoingUp = true;
                                  },
                                  icon: const Icon(
                                    Icons.arrow_right,
                                    color: Colors.white54,
                                  )),
                              Text(
                                lastMoveTXT,
                                style: const TextStyle(color: Colors.white54),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: smallDataTable),
                              flex: 12,
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  IconButton(
                                      iconSize: 20,
                                      //color: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          _expanded = !_expanded;
                                        });
                                      },
                                      icon: const Icon(Icons.fullscreen)),
                                  IconButton(
                                      onPressed: () {
                                        DatabaseHelper.addGame(
                                          ChessGame(
                                            //gameID: 10000,
                                            event: 'r',
                                            site: 'r',
                                            round: 'r',
                                            currentPosition: 'r',
                                            timeZone: 'r',
                                            eco: 'r',
                                            ecoUrl: 'r',
                                            utcDate: 'r',
                                            utcTime: 'r',
                                            termination: 'r',
                                            startTime: 'r',
                                            endTime: 'r',
                                            endDate: 'r',
                                            link: 'r',
                                            rawPGN: 'r',
                                            date: DateTime.now()
                                                .toIso8601String(),
                                            white: 'John',
                                            whiteElo: 2350.toString(),
                                            black: 'Nick',
                                            blackElo: 1235.toString(),
                                            result: '1-0',
                                            moves:
                                                '1. e4 e5 2. Nf3 Bd6 3. d4 Nc6 4. d5 Nb4 5. a3 Na6 6. Bxa6 bxa6 7. Nc3 Nf6 8. O-O Bc5 9. b4 Bd6 10. Re1 Bb7 11. Bg5 h6 12. Bxf6 Qxf6 13. b5 O-O 14. Qd3 Qf4 15. bxa6 Bc8 16. Qc4 h5 17. Ne2 Qf6 18. a4 Re8 19. Rab1 h4 20. h3 Be7 21. Qxc7 Bxa6 22. Nxe5 Bd6 23. Nxd7 Bxc7 24. Nxf6+ gxf6 25. Nd4 Ba5 26. Red1 Rxe4 27. d6 Rd8 28. Nc6 Rd7 29. Nxa5 Rxa4 30. Nc6 f5 31. Ne7+ Rxe7 32. dxe7 Re4 33. Rb8+ Kg7 34. e8=Q Re6 35. Qh8+ Kg6 36. Rg8# 1-0',
                                            timeControl: '',
                                          ),
                                        );
                                        
                                        setState(() {
                                          DatabaseHelper.getAllGames()
                                              .then((value) {
                                            value == null
                                                ? chessGames = []
                                                : chessGames = value;
                                          });
                                        });

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text('Sample data added'),
                                          duration: Duration(milliseconds: 200),
                                        ));
                                      },
                                      icon: Icon(Icons.add)),
                                  // IconButton(
                                  //     iconSize: 20,
                                  //     color: Colors.white,
                                  //     onPressed: () {
                                  //       showModalBottomSheet(
                                  //         context: context,
                                  //         builder: (context) => Scaffold(
                                  //             body: Container(
                                  //           padding:
                                  //               const EdgeInsets.symmetric(
                                  //                   vertical: 20,
                                  //                   horizontal: 20),
                                  //           child: Column(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment
                                  //                       .center,
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment
                                  //                       .stretch,
                                  //               children: [
                                  //                 Text(pickedText),
                                  //                 const SizedBox(
                                  //                   height: 30,
                                  //                 ),
                                  //                 ElevatedButton(
                                  //                     onPressed: () async {
                                  //                       FilePickerResult?
                                  //                           result =
                                  //                           await FilePicker
                                  //                               .platform
                                  //                               .pickFiles();

                                  //                       if (result !=
                                  //                           null) {
                                  //                         setState(() {
                                  //                           pickedText =
                                  //                               'File Picked!';
                                  //                         });
                                  //                         DatabaseHelper
                                  //                             .addGame(
                                  //                           ChessGame(
                                  //                               date: DateTime
                                  //                                       .now()
                                  //                                   .toString(),
                                  //                               whitePlayerName:
                                  //                                   'John',
                                  //                               whitePlayerELO:
                                  //                                   2350,
                                  //                               blackPlayerName:
                                  //                                   'Nick',
                                  //                               blackPlayerELO:
                                  //                                   1235,
                                  //                               result:
                                  //                                   '1-0',
                                  //                               movesCount:
                                  //                                   40,
                                  //                               moves:
                                  //                                   '1. e4 e5 2. Nf3 Bd6 3. d4 Nc6 4. d5 Nb4 5. a3 Na6 6. Bxa6 bxa6 7. Nc3 Nf6 8. O-O Bc5 9. b4 Bd6 10. Re1 Bb7 11. Bg5 h6 12. Bxf6 Qxf6 13. b5 O-O 14. Qd3 Qf4 15. bxa6 Bc8 16. Qc4 h5 17. Ne2 Qf6 18. a4 Re8 19. Rab1 h4 20. h3 Be7 21. Qxc7 Bxa6 22. Nxe5 Bd6 23. Nxd7 Bxc7 24. Nxf6+ gxf6 25. Nd4 Ba5 26. Red1 Rxe4 27. d6 Rd8 28. Nc6 Rd7 29. Nxa5 Rxa4 30. Nc6 f5 31. Ne7+ Rxe7 32. dxe7 Re4 33. Rb8+ Kg7 34. e8=Q Re6 35. Qh8+ Kg6 36. Rg8# 1-0',
                                  //                               timeControl:
                                  //                                   'timeCtrl',
                                  //                               timeClass:
                                  //                                   'TimeClass',
                                  //                               wAccuracy:
                                  //                                   'WACC',
                                  //                               bAccuracy:
                                  //                                   'BACC',
                                  //                               wCPL:
                                  //                                   'wCpl',
                                  //                               bCPL:
                                  //                                   'bCPL'),
                                  //                         );
                                  //                         Navigator.pop(
                                  //                             context);
                                  //                       } else {
                                  //                         // User canceled the picker
                                  //                       }
                                  //                     },
                                  //                     child: const Text(
                                  //                         'Pick file'))
                                  //               ]),
                                  //         )),
                                  //       );
                                  //     },
                                  //     icon: const Icon(Icons.add)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
          )),
    );
  }
}
