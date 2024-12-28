import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  IO.Socket? socket;
  static SocketClient? _instance;

  // Constructor
  SocketClient._internal() {
    // Initialize the socket with the server URL and options
    socket = IO.io('http://192.168.1.15:3000', <String, dynamic>{
      'transports': [
        'websocket'
      ], // Specifies that WebSocket is the transport method
      'autoConnect': false, // Prevents the socket from automatically connecting
    });

    socket!.connect(); // Manually connects the socket to the server

    // Debugging connection status
    socket!.onConnect((_) {
      log('Connected to the server');
    });
    socket!.onConnectError((error) {
      log('Connection Error: $error');
    });
    socket!.onDisconnect((_) {
      log('Disconnected from the server');
    });
  }

  // Singleton instance getter
  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
