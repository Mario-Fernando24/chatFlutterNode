import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatmongoflutter/routes/routes.dart';
import 'package:chatmongoflutter/services/lib/service/lib/service/auth_services.dart';
import 'package:chatmongoflutter/services/lib/service/lib/service/socket_service.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: ( _ )=>AuthService() ),
        ChangeNotifierProvider( create: ( _ )=>SocketService() )
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