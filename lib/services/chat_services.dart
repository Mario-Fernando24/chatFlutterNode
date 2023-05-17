import 'package:chatmongoflutter/global/environment.dart';
import 'package:chatmongoflutter/models/mensajes_response.dart';
import 'package:chatmongoflutter/models/usuarios.dart';
import 'package:chatmongoflutter/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 

class ChatService with ChangeNotifier{
  
  Usuario? usuarioPara;

  // le paso el usuario id que deseo leer los mensaje que esta relacionado con mi uid
  Future<List<Mensaje>> getChat(String usuarioId) async{
     

        final token = await AuthService.geToken();

         var url = Uri.parse('${Environment.apiUrl}/mensaje/${usuarioId}');
         
          final resp = await http.get(url, 
                headers: {
                  'Content-Type': 'application/json',
                  'x-token': token.toString()
                }
              );

          final usuarioResponse = mensajeResponseFromJson(resp.body);

          return usuarioResponse.mensajes;


  }
  

}