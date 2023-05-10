//todas las rutas
import 'package:chatmongoflutter/pages/chat_page.dart';
import 'package:chatmongoflutter/pages/loading_page.dart';
import 'package:chatmongoflutter/pages/login_page.dart';
import 'package:chatmongoflutter/pages/register_page.dart';
import 'package:chatmongoflutter/pages/usuario_page.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext )> appRoutes = {
  'usuario'   : ( _ ) => UsuarioPage(),
  'chat'      : ( _ ) => ChatPage(),
  'login'     : ( _ ) => LoginPage(),
  'register'  : ( _ ) => RegisterPage(),
  'loading'   : ( _ ) => LoadingPage()
};