import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/resources/socket_method.dart';
import 'package:tic_tac_toe/views/scorebord.dart';
import 'package:tic_tac_toe/views/tictactoe.dart';
import 'package:tic_tac_toe/views/wating_lobby.dart';

class GameScreen extends StatefulWidget {
  static String routName = '/game';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethod _socketMethod = SocketMethod();

  @override
  void initState() {
    super.initState();
    _socketMethod.updateRoomListner(context);
    _socketMethod.updatePlayerStateListener(context);
    _socketMethod.pointIncreaseListner(context);
    _socketMethod.endGameListner(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    Provider.of<RoomDataProvider>(context).roomData.toString();
    return Scaffold(
      body: roomDataProvider.roomData['isJoin']
          ? const WatingLobby()
          : SafeArea(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Scorebord(),
                TictactoeBoard(),
                Text(
                    '${roomDataProvider.roomData['turn']['nickname']} \'s turn')
              ],
            )),
    );
  }
}
