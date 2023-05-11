import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  
  final String text;
  final String uid;

  const ChatMessage({super.key, required this.text, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Container(
         child: this.uid=='123'?
         _myMessage():
         _noMyMessage(),
    );
  }
  
  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 5.0, left: 50.0,right: 7),
        child: Text(this.text, style: TextStyle(color: Colors.white),),
        decoration: BoxDecoration(
          color: Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }
  
  Widget _noMyMessage() {
     return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 5.0, left: 5.0,right: 50),
        child: Text(this.text, style: TextStyle(color: Colors.black87),),
        decoration: BoxDecoration(
          color: Color(0xFFA8A9A9),
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }
}