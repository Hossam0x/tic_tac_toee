import 'package:flutter/material.dart';
import 'package:tic_tac_toe/responsive/responsive.dart';
import 'package:tic_tac_toe/screens/create_room_screen.dart';
import 'package:tic_tac_toe/screens/join_room_screen.dart';
import 'package:tic_tac_toe/widgets/custome_button.dart';

class MainMenuScreen extends StatelessWidget {
  static String routName = '/main-menu';
  const MainMenuScreen({super.key});
  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Responsive(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomeButton(
              onTap: () {
                createRoom(context);
              },
              text: "Create Room"),
          const SizedBox(
            height: 20,
          ),
          CustomeButton(
              onTap: () {
                joinRoom(context);
              },
              text: "Join Room")
        ],
      ),
    ));
  }
}
