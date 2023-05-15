import 'package:chatmongoflutter/global/environment.dart';
import 'package:chatmongoflutter/services/lib/service/lib/service/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}


class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;

  Function get emit => this._socket.emit;

 

   Future conectarSocket() async { 

    final token = await AuthService.geToken();
    // Dart client
    this._socket = IO.io('${Environment.socketUrl}', {
      'transports': ['websocket'],
      'autoConnect': true,
      //  forzar una nueva session del token, consume mas recurso cada ves que un cliente se desconecta hace una nueva instancia
      'forceNew': true,
      //enviar token
      'extraHeaders': {
        'x-token': token
      }
    });

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

   

  }


  void disconnect() {

    this._socket.disconnect();
  }

}