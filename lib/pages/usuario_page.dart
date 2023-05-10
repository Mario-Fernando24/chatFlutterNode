import 'package:chatmongoflutter/models/usuarios.dart';
import 'package:flutter/material.dart';

class UsuarioPage extends StatefulWidget {
  
  @override
  State<UsuarioPage> createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {

  final usuario=[
    Usuario(uid: '1', nombre: 'Mario', email: "test1@gmail.com", online: true),
    Usuario(uid: '2', nombre: 'Xiomy', email: "test1@gmail.com", online: false),
    Usuario(uid: '3', nombre: 'DO', email: "test1@gmail.com", online: true),
    Usuario(uid: '3', nombre: 'CAMILA', email: "test1@gmail.com", online: false),
    Usuario(uid: '4', nombre: 'LILIANA', email: "test1@gmail.com", online: true),
    Usuario(uid: '5', nombre: 'VICTORIA', email: "test1@gmail.com", online: false),
    // Usuario(uid: '6', nombre: 'ARIADNA', email: "test1@gmail.com", online: false),
    // Usuario(uid: '7', nombre: 'SADYSS', email: "test1@gmail.com", online: true),
    // Usuario(uid: '8', nombre: 'BEBE', email: "test1@gmail.com", online: true),
    // Usuario(uid: '9', nombre: 'p', email: "test1@gmail.com", online: true),
    // Usuario(uid: '10', nombre: 'SADYS', email: "test1@gmail.com", online: true),
    // Usuario(uid: '11', nombre: 'SADYS', email: "test1@gmail.com", online: true),
    // Usuario(uid: '12', nombre: 'SADYS', email: "test1@gmail.com", online: true),

  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Mi nombre', style: TextStyle(color: Colors.black54),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app,color: Colors.black54,),
          onPressed: () {},
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              // child: Icon(Icons.check_circle, color: Colors.blue[400],),
               child: Icon(Icons.offline_bolt, color: Colors.red),
            )
          ],
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: ( _ , i ) => ListTile(
          title: Text(usuario[i].nombre ?? ""),
          leading: CircleAvatar(
            child: Text(usuario[i].nombre!.substring(0,2)),
          ),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: usuario[i].online==true ? Colors.green[300] : Colors.red[300],
              borderRadius: BorderRadius.circular(100)
            ),
          ),
        ),
        separatorBuilder: ( _ , i ) => Divider(),
        itemCount: usuario.length,
      )
    );
  }
}