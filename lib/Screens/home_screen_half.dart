import 'package:chess_app/Screens/home_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../providers/CHESS_GAMES.dart';
import '../Widgets/chess_board_builder.dart';

class HomeScreenHalf extends StatefulWidget {
  const HomeScreenHalf({super.key});

  @override
  State<HomeScreenHalf> createState() => _HomeScreenHalfState();
}

class _HomeScreenHalfState extends State<HomeScreenHalf> {
  bool _expanded = false;
  String pickedText = "no file picked yet";

  @override
  Widget build(BuildContext context) {
    var smallDataTable = ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
                columnSpacing: 18,
                headingTextStyle: TextStyle(fontSize: 13, color: Colors.black),
                dataTextStyle: TextStyle(
                    fontSize: 13, color: const Color.fromARGB(255, 90, 82, 82)),
                decoration: BoxDecoration(color: Colors.white),
                sortColumnIndex: 1,
                sortAscending: true,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('Date'),
                  ),
                  DataColumn(
                    label: Text('White Player'),
                  ),
                  DataColumn(
                    label: Text('(ELO)'),
                  ),
                  DataColumn(
                    label: Text('-'),
                  ),
                  DataColumn(
                    label: Text('Black Player'),
                  ),
                  DataColumn(
                    label: Text('(ELO)'),
                  ),
                  DataColumn(
                    label: Text('Result'),
                  ),
                ],
                rows: chessGames
                    .map((chessGame) => DataRow(cells: [
                          DataCell(
                            Text(chessGame.date.toString()),
                          ),
                          DataCell(
                            Text(chessGame.whitePlayerName),
                          ),
                          DataCell(
                            Text(chessGame.whitePlayerELO.toString()),
                          ),
                          const DataCell(
                            Text('-'),
                          ),
                          DataCell(
                            Text(chessGame.blackPlayerName),
                          ),
                          DataCell(
                            Text(chessGame.blackPlayerELO.toString()),
                          ),
                          DataCell(
                            Text(chessGame.result),
                          ),
                        ]))
                    .toList()),
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Chess'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.menu))],
      ),
      body: Container(
          color: const Color.fromRGBO(48, 46, 43, 1),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: _expanded
                ? Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      color: Colors.white38,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 12,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            //child: bigDataTable,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                              iconSize: 20,
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  _expanded = !_expanded;
                                });
                              },
                              icon: Icon(Icons.fullscreen_exit)),
                        ),
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: ChessBoardBuilder(),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          flex: 4,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              color: Colors.white38,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 12,
                                    child: //smallDataTable,
                                        Navigator(
                                      onGenerateRoute: (settings) {
                                        return MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        );
                                      },
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          iconSize: 20,
                                          color: Colors.white,
                                          onPressed: () {
                                            setState(() {
                                              _expanded = !_expanded;
                                            });
                                          },
                                          icon: Icon(Icons.fullscreen)),
                                      IconButton(
                                          iconSize: 20,
                                          color: Colors.white,
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) => Scaffold(
                                                  body: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20,
                                                    horizontal: 20),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Text(pickedText),
                                                      SizedBox(
                                                        height: 30,
                                                      ),
                                                      ElevatedButton(
                                                          onPressed: () async {
                                                            FilePickerResult?
                                                                result =
                                                                await FilePicker
                                                                    .platform
                                                                    .pickFiles();

                                                            if (result !=
                                                                null) {
                                                              setState(() {
                                                                pickedText =
                                                                    'File Picked!';
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            } else {
                                                              // User canceled the picker
                                                            }
                                                          },
                                                          child:
                                                              Text('Pick file'))
                                                    ]),
                                              )),
                                            );
                                          },
                                          icon: Icon(Icons.add)),
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
