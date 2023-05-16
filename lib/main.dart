import 'package:chatmongoflutter/services/auth_services.dart';
import 'package:chatmongoflutter/services/chat_services.dart';
import 'package:chatmongoflutter/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatmongoflutter/routes/routes.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: ( _ )=>AuthService() ),
        ChangeNotifierProvider( create: ( _ )=>SocketService() ),
        ChangeNotifierProvider( create: ( _ )=>ChatService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }  
}