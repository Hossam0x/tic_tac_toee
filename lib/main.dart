import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/screens/create_room_screen.dart';
import 'package:tic_tac_toe/screens/game_Screen.dart';
import 'package:tic_tac_toe/screens/join_room_screen.dart';
import 'package:tic_tac_toe/screens/main_menu_screen.dart';
import 'package:tic_tac_toe/utils/colors.dart';

void main() {
  runApp(const TicTocApp());
}

// FutureBuilder: take a req => send it
// StreameBuilder: can take a req => send it -> listens to it
//snapshot -> Stream -> Socket io

// http - one way
//Soket io - Two way
class TicTocApp extends StatelessWidget {
  const TicTocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: bgColor),
        routes: {
          MainMenuScreen.routName: (context) => const MainMenuScreen(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          GameScreen.routName: (context) => const GameScreen()
        },
        home: const MainMenuScreen(),
      ),
    );
  }
}
