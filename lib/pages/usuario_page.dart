import 'package:chatmongoflutter/services/lib/service/lib/service/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:chatmongoflutter/models/usuarios.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuarioPage extends StatefulWidget {
  
  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final usuario=[
    Usuario(uid: '1', nombre: 'Mario', email: "test1@gmail.com", online: true),
    Usuario(uid: '2', nombre: 'Xiomy', email: "test1@gmail.com", online: false),
    Usuario(uid: '3', nombre: 'DO', email: "test1@gmail.com", online: true),
    Usuario(uid: '3', nombre: 'CAMILA', email: "test1@gmail.com", online: false),
    Usuario(uid: '4', nombre: 'LILIANA', email: "test1@gmail.com", online: true),
    Usuario(uid: '5', nombre: 'VICTORIA', email: "test1@gmail.com", online: false),
  ];
  @override
  Widget build(BuildContext context) {

    final authServices = Provider.of<AuthService>(context);
    final usuario = authServices.usuario;

    return  Scaffold(
      appBar: AppBar(
        title: Text(usuario?.nombre ?? '', style: TextStyle(color: Colors.black54),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app,color: Colors.black54,),
          onPressed: () {
             // Desconectar el socket and salir de la app y eliminar el storage
             Navigator.pushReplacementNamed(context, 'login');
             AuthService.deleteToken();
          },
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              // child: Icon(Icons.check_circle, color: Colors.blue[400],),
               child: Icon(Icons.offline_bolt, color: Colors.red),
            )
          ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuario,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue.shade400),
          waterDropColor: Colors.blue.shade400
        ),
        child: _listViewUsuario(),
        )
    );
  }

   ListView _listViewUsuario(){

    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: ( _ , i ) => usuarioList(usuario[i]),
        separatorBuilder: ( _ , i ) => Divider(),
        itemCount: usuario.length,
      );

  }
  

  ListTile usuarioList(Usuario usuario) {

    return ListTile(
          title: Text(usuario.nombre ?? ""),
          leading: CircleAvatar(
            child: Text(usuario.nombre!.substring(0,2)),
            backgroundColor: Colors.blue[100],
          ),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: usuario.online==true ? Colors.green[300] : Colors.red[300],
              borderRadius: BorderRadius.circular(100)
            ),
          ),
        );
  }

  void _cargarUsuario() async{
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

}