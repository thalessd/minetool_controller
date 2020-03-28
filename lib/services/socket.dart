import 'package:socket_io_client/socket_io_client.dart' as IO;

class Socket {

  IO.Socket _socket;

  Socket(url) {
    _socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false
    });
  }

  void connect() {
    _socket.connect();
  }

  void onConnect(evt) {
    _socket.on("connect", evt);
  }

  void onUserLogged(evt) {
    _socket.on("user_logged", evt);
  }
}