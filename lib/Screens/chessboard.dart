import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
//import 'package:chess_app/Providers/games.pgn' as games;

class ChessPage extends StatefulWidget {
  const ChessPage({Key? key}) : super(key: key);

  @override
  State<ChessPage> createState() => _ChessPageState();
}

class _ChessPageState extends State<ChessPage> {
  ChessBoardController controller = ChessBoardController();

  List<String> moves =[];
  int i = 0;
  bool isGoingUp =true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chess Demo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ChessBoard(
                controller: controller,
                boardColor: BoardColor.orange,
                boardOrientation: PlayerColor.white,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ValueListenableBuilder<Chess>(
                valueListenable: controller,
                builder: (context, game, _) {
                  return Text(
                    controller.getSan().fold(
                          '',
                          (previousValue, element) =>
                              previousValue + '\n' + (element ?? ''),
                        ),
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                controller.loadPGN('1. b3 d5 2. Bb2 Bf5 3. Nf3 e6 4. e3 h6 5. c4 Nf6 6. cxd5 exd5 7. Be2 c6 8. O-O Bd6 9. d3 O-O 10. Nbd2 Nbd7 11. Re1 Bh7 12. Bf1 Re8 13. a3 a5 14. Qc2 Ne5 15. Nxe5 Bxe5 16. Bxe5 Rxe5 17. b4 Re8 18. Nb3 axb4 19. axb4 Nd7 20. Qc3 Qe7 21. Rxa8 Rxa8 22. Na5 Nf8 23. Ra1 Qd7 24. Nb3 Rxa1 25. Qxa1 b6 26. Qa8 Bg6 27. Qb8 b5 28. Nd4 f6 29. Be2 Be8 30. h4 h5 31. g3 g6 32. Bf1 Kg7 33. Bh3 f5 34. Qe5+ Kf7 35. Qh8 Qd6 36. Nc2 Qf6 37. Qxf6+ Kxf6 38. Kf1 Ne6 39. Ke2 Ke5 40. Kd2 Bd7 41. Ne1 Kf6 42. Kc3 Be8 43. f4 Bd7 44. Nf3 Be8 45. Ne5 Ke7 46. Bg2 Kd6 47. Nf3 c5 48. bxc5+ Kxc5 49. d4+ Kd6 50. Kb4 Nc7 51. Bf1 Na6+ 52. Ka5 Nc7 53. Ne5 Ke6 54. Kb6 Kd6 55. Bd3 Na8+ 56. Ka5 Nc7 57. Nf3 Ke6 58. Kb6 Kd6 59. Nd2 Na8+ 60. Ka5 Nc7 61. Nb1 Bd7 62. Nc3 Ne8 63. Bxb5 Nf6 64. Kb6 Ng4 65. Bxd7 Kxd7 66. Kc5 Nxe3 67. Nxd5 Nf1 68. Nb6+ Kc7 69. Nc4 Nxg3 70. Ne5 Ne4+ 71. Kd5 Nf6+ 72. Ke6 Ne4 73. d5 Nc5+ 74. Ke7 Ne4 75. Nxg6 Kb6 76. d6 Kc6 77. d7 1-0');
                if(i >2){
                  i = 0;
                }
                //controller.loadFen(moves[i]);
                //print(controller.getMoveCount());
                i++;
              },
              child: Text('1.Read Moves')),
              ElevatedButton(
              onPressed: () {
                //controller.undoMove();
                print(controller.getSan());
                moves = controller.getSan().cast<String>();
              },
              child: Text('2.Load moves')),
              ElevatedButton(
              onPressed: () {
                //controller.undoMove();
                String pgnstring = '';
                if(!isGoingUp){
                  i = i+2;
                }

                if(i <0){
                  i = 0;
                }
                if(i >moves.length-1){
                  i = moves.length-1;
                }
                for(int j = 0; j<i;j++){
                  pgnstring = pgnstring + moves[j] + ' ';
                }
                print(pgnstring);
                controller.loadPGN(pgnstring);

                
                i++;
                isGoingUp = true;
              },
              child: Text('scroll moves up')),
              ElevatedButton(
              onPressed: () {
                //controller.undoMove();
                String pgnstring = '';

                if(isGoingUp){
                  i = i-2;
                }
                if(i >moves.length-1){
                  i = moves.length-1;
                }
                if(i <0){
                  i = 0;
                }
                for(int j = 0; j<i;j++){
                  pgnstring = pgnstring + moves[j] + ' ';
                }
                print(pgnstring);
                controller.loadPGN(pgnstring);

                
                i--;
                isGoingUp = false;
              },
              child: Text('scroll moves down')),
        ],
      ),
    );
  }
}
