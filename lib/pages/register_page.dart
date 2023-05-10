import 'package:chatmongoflutter/widget/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widget/boton_azul.dart';
import '../widget/label.dart';
import '../widget/logo.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                 Logo(titulo: 'Registro'),
                _Form(),
                Labels(ruta: 'login',titulo: 'Ya tienes una cuenta?', subTitulo: 'Ingresa ahora!',),
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

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
       
          CustomInput(
            icon: Icons.perm_identity,
            placeHolder: 'Nombre',
            keyboardType: TextInputType.text,
            textEditingController:nameCtrl ,
          ),

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
            onPressed: (){
              print(emailCtrl.text);
              print(passwordCtrl.text);
            },
          )
        ],
      ),
    );
  }
}

