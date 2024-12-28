import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resources/socket_client.dart';
import 'package:tic_tac_toe/screens/game_Screen.dart';

class SocketMethod {
  final _socketClient = SocketClient.instance.socket!;

  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      print('Nickname sent: $nickname'); // Debugging print
      _socketClient.emit("createRoom", {'nickname': nickname});
    } else {
      print('Nickname is empty'); // Debugging print
    }
  }

  void createRoomSuccessListner(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      print('Room created successfully: $room'); // Debugging print
      Navigator.pushNamed(context, GameScreen.routName);
    });

    // Add error handling for debugging
    _socketClient.on('error', (data) {
      print('Socket Error: $data');
    });
  }
}
