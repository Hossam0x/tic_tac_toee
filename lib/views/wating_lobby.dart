import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/provider/room_data_provider.dart';
import 'package:tic_tac_toe/widgets/custome_textfield.dart';

class WatingLobby extends StatefulWidget {
  const WatingLobby({super.key});

  @override
  State<WatingLobby> createState() => _WatingLobbyState();
}

class _WatingLobbyState extends State<WatingLobby> {
  late TextEditingController roomIdController;
  @override
  void initState() {
    super.initState();
    roomIdController = TextEditingController(
      text:
          Provider.of<RoomDataProvider>(context, listen: false).roomData["_id"],
    );
  }

  @override
  void dispose() {
    super.dispose();
    roomIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Wating for other player'),
        const SizedBox(
          height: 20,
        ),
        CustomeTextfield(
          controller: roomIdController,
          hintText: "",
          isReadOnly: true,
        ),
      ],
    );
  }
}
