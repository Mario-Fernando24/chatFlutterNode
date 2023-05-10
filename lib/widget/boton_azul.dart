import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

   final String text;
   final void Function()? onPressed;  

   const BotonAzul({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      style: ButtonStyle( minimumSize: MaterialStateProperty.all(Size(265, 46))),
      child: Text(text),
      onPressed:  onPressed
    );
  }
}