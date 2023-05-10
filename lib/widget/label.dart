import 'package:flutter/material.dart';

class Labels extends StatefulWidget {

  @override
  State<Labels> createState() => _LabelsState();
}

class _LabelsState extends State<Labels> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('¿No tienes cuenta?', style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300)),
        SizedBox(height: 10,),
        Text('Crea una ahora!', style: TextStyle(color: Colors.blue[600], fontSize:   18, fontWeight: FontWeight.bold  ),),

      ],
    );
  }
}