import 'package:flutter/material.dart';
import 'package:tic_tac_toe/models/player.dart';

class RoomDataProvider extends ChangeNotifier {
  // notifyListener
  Map<String, dynamic> _roomData = {};
  List<String> _displayElement = ['', '', '', '', '', '', '', '', ''];
  int _filledBoxes = 0;
  Player _player1 = Player(
    nickname: "",
    socketID: "",
    points: 0,
    playerType: 'X',
  );
  Player _player2 = Player(
    nickname: "",
    socketID: "",
    points: 0,
    playerType: 'O',
  );

  Map<String, dynamic> get roomData => _roomData;
  int get filledBoxes => _filledBoxes;
  List<String> get displayElement => _displayElement;
  Player get player1 => _player1;
  Player get player2 => _player2;
  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }

  void updateDisplayElement(int index, String choice) {
    _displayElement[index] = choice;
    _filledBoxes += 1;
    notifyListeners();
  }

  void setfilledBoxesTo0() {
    _filledBoxes = 0;
  }
}
