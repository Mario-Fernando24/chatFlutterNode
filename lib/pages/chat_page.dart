import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:chatmongoflutter/widget/chat_message.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  bool _estadoEscribiendo = false; 

  List<ChatMessage> _message = [
      ChatMessage(text: 'Hola bebe', uid: '123'),
      ChatMessage(text: 'porque no me quieres hablar', uid: '123'),
      ChatMessage(text: 'porfavor llamame', uid: '123'),
      ChatMessage(text: 'Este es mi numero 317757268', uid: '1293'),
      ChatMessage(text: 'SAMACACA 🥰🥰🥰🥰💋💋❤️💓💓', uid: '1283')

  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
            children: [
              CircleAvatar(
                child: Text('Te', style: TextStyle(fontSize: 12, color: Colors.white)),
                backgroundColor: Colors.blue.shade400,
                maxRadius: 14,
              ),
              SizedBox(height: 3),
              Text('SAMACACA', style: TextStyle(color: Colors.black87, fontSize: 12))
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
     
     _textController.clear();
     _focusNode.requestFocus();
     final newMessage = new ChatMessage(text: text, uid: '123');
     _message.insert(0, newMessage);
     setState(() { _estadoEscribiendo=false; });

  }

}