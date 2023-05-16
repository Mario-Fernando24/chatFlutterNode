import 'package:chatmongoflutter/global/environment.dart';
import 'package:chatmongoflutter/models/usuario_response.dart';
import 'package:chatmongoflutter/models/usuarios.dart';
import 'package:chatmongoflutter/services/auth_services.dart';
import 'package:http/http.dart' as http; 

class UsuarioServices{


  Future<List<Usuario>> getUsuario() async {
      
      try {

        final token = await AuthService.geToken();

         var url = Uri.parse('${Environment.apiUrl}/usuario/');
         
          final resp = await http.get(url, 
                headers: {
                  'Content-Type': 'application/json',
                  'x-token': token.toString()
                }
              );

          final usuarioResponse = usuarioResponseFromJson(resp.body);
          return usuarioResponse.usuario;

      } catch (e) {
          return [];
      }
  }

}