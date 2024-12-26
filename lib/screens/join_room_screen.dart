import 'package:flutter/material.dart';
import 'package:tic_tac_toe/responsive/responsive.dart';
import 'package:tic_tac_toe/widgets/custom_text.dart';
import 'package:tic_tac_toe/widgets/custome_button.dart';
import 'package:tic_tac_toe/widgets/custome_textfield.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _gameIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _gameIdController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                shadows: [
                  Shadow(
                    blurRadius: 40,
                    color: Colors.blue,
                  )
                ],
                text: "Join Room",
                fontsize: 70,
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomeTextfield(
                  controller: _nameController, hintText: "Enter your nickname"),
              const SizedBox(
                height: 20,
              ),
              CustomeTextfield(
                  controller: _gameIdController, hintText: "Enter Game Id"),
              SizedBox(
                height: size.height * 0.045,
              ),
              CustomeButton(onTap: () {}, text: "Create")
            ],
          ),
        ),
      ),
    );
  }
}
