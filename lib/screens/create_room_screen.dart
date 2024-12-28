import 'package:flutter/material.dart';
import 'package:tic_tac_toe/resources/socket_method.dart';
import 'package:tic_tac_toe/responsive/responsive.dart';
import 'package:tic_tac_toe/widgets/custom_text.dart';
import 'package:tic_tac_toe/widgets/custome_button.dart';
import 'package:tic_tac_toe/widgets/custome_textfield.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final SocketMethod _socketMethod = SocketMethod();

  @override
  void initState() {
    super.initState();
    _socketMethod.createRoomSuccessListner(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
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
                text: "Create Room",
                fontsize: 70,
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomeTextfield(
                controller: _nameController,
                hintText: "Enter your nickname",
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomeButton(
                onTap: () {
                  _socketMethod.createRoom(_nameController.text);
                },
                text: "Create",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
