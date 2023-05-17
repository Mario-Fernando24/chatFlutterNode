import 'package:chatmongoflutter/services/auth_services.dart';
import 'package:chatmongoflutter/services/chat_services.dart';
import 'package:chatmongoflutter/services/socket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:chatmongoflutter/widget/chat_message.dart';
import 'package:provider/provider.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>  with TickerProviderStateMixin{

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  bool _estadoEscribiendo = false; 

  ChatService? chatServices;
  SocketService? socketService;
  AuthService? authService;


  List<ChatMessage> _message = [];

  @override
  void initState() {
    super.initState();
    this.chatServices = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);

    //escuchar un evento
    this.socketService!.socket.on('mensaje-personal', _escucharMensaje); 
  }

  void _escucharMensaje(dynamic data){
    ChatMessage message = new ChatMessage(text: data['mensaje'], 
    uid: data['de'],
     animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 600))
     );

     setState(() {
       _message.insert(0, message);
     });
     message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
            children: [
              CircleAvatar(
                child: Text(chatServices!.usuarioPara!.nombre.substring(0,2), style: TextStyle(fontSize: 12, color: Colors.white)),
                backgroundColor: Colors.blue.shade400,
                maxRadius: 14,
              ),
              SizedBox(height: 3),
              Text(chatServices!.usuarioPara!.nombre ?? '', style: TextStyle(color: Colors.black87, fontSize: 12))
            ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _message.length,
                itemBuilder: (_, i)=>_message[i],
                reverse: true,
                )
              ),
              Divider(height: 1,),
              //Caja de texto
              Container(
                color: Colors.white,
                height: 50,
                child: _inputChat(),
              )
          ],
        ),
      ),
    );
  }

  Widget _inputChat(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
         children: [
           Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: obtenerTextCaja,
              onChanged: (String text){
                setState(() {
                   if(text.trim().length>0){
                    _estadoEscribiendo=true;     
                   }else{
                    _estadoEscribiendo=false;     
                   }             
                });
              },
              //cuando haya un valor para poder enviar
              decoration: InputDecoration.collapsed(
                hintText: 'Enviar mensaje'
                ),
                focusNode: _focusNode,
             ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
              ? CupertinoButton(
                child: Text('Enviar'), 
                onPressed: _estadoEscribiendo?()=>obtenerTextCaja(_textController.text.trim()):null
                ):Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.blue.shade400),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent ,
                      icon: Icon(Icons.send),
                      onPressed: _estadoEscribiendo?()=>obtenerTextCaja(_textController.text.trim()):null,
                       ),
                  ),
                ),
            )
         ],
        ),
      )
      );
  }

  obtenerTextCaja(String text){
    if(text.length == 0) return ;
     
     _textController.clear();
     _focusNode.requestFocus();
     final newMessage = new ChatMessage(text: text, uid: '123',animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 600)),);
     _message.insert(0, newMessage);
     newMessage.animationController.forward();
     setState(() { _estadoEscribiendo=false; });

     this.socketService!.emit('mensaje-personal', {
           'de': authService?.usuario?.uid,
           'para': chatServices?.usuarioPara?.uid,
           'mensaje': text
     });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    for(ChatMessage message in _message){
      message.animationController.dispose();
    }

    this.socketService!.socket.off('mensaje-personal');
    super.dispose();
  }

}