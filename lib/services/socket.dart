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

  void onServerRunning(evt) {
    _socket.on("server_running", evt);
  }

  void onServerDone(evt) {
    _socket.on("server_is_done", evt);
  }

  void onServerStop(evt) {
    _socket.on("server_stopped", evt);
  }

  void onServerError(evt) {
    _socket.on("server_errored", evt);
  }

  void onServerStatsInfo(evt) {
    _socket.on("server_stats", evt);
  }

  void onServerStatusData(evt) {
    _socket.on("server_status_data", evt);
  }

  void onUserLogged(evt) {
    _socket.on("user_logged", evt);
  }

  void onUserLoggedOut(evt) {
    _socket.on("user_logged_out", evt);
  }

  void emitServerStatus() {
    _socket.emit("server_status");
  }

  void emitServerRun() {
    _socket.emit("server_run");
  }

  void emitServerStop() {
    _socket.emit("server_stop");
  }

  void emitServerRestart() {
    _socket.emit("server_restart");
  }

  void emitUserKick(String user, {String reason = ""}) {
    _socket.emit("kick", [user, reason]);
  }

  void emitUserSay(String message, { String user = "" }) {
    _socket.emit("say", [message, user]);
  }
}