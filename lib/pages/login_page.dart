import 'package:chatmongoflutter/helpers/show_alert.dart';
import 'package:chatmongoflutter/services/auth_services.dart';
import 'package:chatmongoflutter/services/socket_service.dart';
import 'package:chatmongoflutter/widget/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../widget/boton_azul.dart';
import '../widget/label.dart';
import '../widget/logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height*0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Logo(titulo: 'Login'),
                _Form(),
                Labels(ruta: 'register',titulo: '¿No tienes cuenta?', subTitulo: 'Crea una ahora!',),
                Text('Términos y condiciones', style: TextStyle(fontWeight: FontWeight.w300),)
              ],
            ),
          ),
        ),
      )
    );
  }
}


class _Form extends StatefulWidget {

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail,
            placeHolder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textEditingController:emailCtrl ,
          ),


            CustomInput(
            icon: Icons.lock_outline,
            placeHolder: 'Contraseña',
            textEditingController:passwordCtrl ,
            isPassword: true,
          ),
         
                    
          BotonAzul(
            text: 'Ingresar',
            onPressed:  authService.autenticando==true? null:() async{
              //ocultar el teclado cuando presionamos en entrar
              FocusScope.of(context).unfocus();
              final loginOk = await authService.login(emailCtrl.text.trim(), passwordCtrl.text.trim());
              if(loginOk){
                  //conectar con nuestro token
                  await socketService.conectarSocket();
                  Navigator.pushReplacementNamed(context, 'usuario');
              }else{
                // ignore: use_build_context_synchronously
                showAlert(context, 'Login incorrecto', 'Revise sus credenciales nuevamente');
              }
            },
          )
        ],
      ),
    );
  }
}

