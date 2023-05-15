import 'package:chatmongoflutter/pages/usuario_page.dart';
import 'package:chatmongoflutter/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: ( context,snapshot) { 
          return Center(
            child: Text('Espere...')
          );
         },
        
      ),
    );
  }

  Future checkLoginState(BuildContext context) async{

    final auth = Provider.of<AuthService>(context, listen: false);
    bool autenticado = await auth.isLoggedIn();

    if(autenticado==true){
        //conectar socket
      Navigator.pushReplacementNamed(context, 'usuario');
     

    }else{
       
      Navigator.pushReplacementNamed(context, 'login');

    }

  }
}