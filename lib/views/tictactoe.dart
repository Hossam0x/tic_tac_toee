import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/resources/socket_method.dart';

class TictactoeBoard extends StatefulWidget {
  const TictactoeBoard({super.key});

  @override
  State<TictactoeBoard> createState() => _TictactoeBoardState();
}

class _TictactoeBoardState extends State<TictactoeBoard> {
  final SocketMethod _socketMethod = SocketMethod();

  @override
  void initState() {
    super.initState();
    _socketMethod.tappedListner(context);
  }

  void tapped(int index, RoomDataProvider roomDataProvider) {
    _socketMethod.tapGrid(
      index,
      roomDataProvider.roomData["_id"],
      roomDataProvider.displayElement,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size.height * 0.7, maxWidth: 500),
      child: AbsorbPointer(
        absorbing: roomDataProvider.roomData['turn']['socketID'] !=
            _socketMethod.socketClinet.id,
        child: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  tapped(index, roomDataProvider);
                },
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white24)),
                  child: Center(
                    child: AnimatedSize(
                      duration: const Duration(microseconds: 200),
                      child: Text(
                        roomDataProvider.displayElement[index],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 100,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 40,
                                color: roomDataProvider.displayElement[index] ==
                                        'O'
                                    ? Colors.red
                                    : Colors.blue,
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
