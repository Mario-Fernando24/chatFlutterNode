import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chatmongoflutter/models/login_response.dart';
import 'package:chatmongoflutter/models/usuarios.dart';
import 'package:chatmongoflutter/global/environment.dart';

class AuthService with ChangeNotifier{
    
    Usuario? usuario;
    bool _autenticando = false;
     //crear instancia storage
    final _storage = new FlutterSecureStorage();

    bool get autenticando => this._autenticando;
    set autenticando(bool valor){
      this._autenticando = valor;

      notifyListeners();
    }

    //retornar el token
    static Future<String> geToken() async{
        final _storage = new FlutterSecureStorage();
        final token = await _storage.read(key: 'token');
        return token.toString();
    }

     static Future deleteToken() async{
        final _storage = new FlutterSecureStorage();
              await _storage.delete(key: 'token');
    }


    Future<bool> login(String email, String password) async{

      this.autenticando = true;

          final data = {
            'email': email,
            'password': password
          };

          var url = Uri.parse('${Environment.apiUrl}/login');
         
          final resp = await http.post(url, 
                body: jsonEncode(data),
                headers: {
                  'Content-Type': 'application/json',
                }
              );

          this.autenticando = false;
          print(resp.body);

          if(resp.statusCode==200){

           final loginnResponse = loginResponseFromJson(resp.body);
           this.usuario =loginnResponse.usuario;
           saveToken(loginnResponse.token);
           return true;

          }else{
            return false;
          }
          
    }


    Future register(String name ,String email, String password) async{

        this.autenticando = true;

        final data = {
            'nombre': name,
            'email': email,
            'password': password
          };

        var url = Uri.parse('${Environment.apiUrl}/login/new');

          final resp = await http.post(url, 
                body: jsonEncode(data),
                headers: {
                  'Content-Type': 'application/json',
                }
              );

          this.autenticando = false;
          print(resp.body);

          if(resp.statusCode==200){

           final loginnResponse = loginResponseFromJson(resp.body);
           this.usuario = loginnResponse.usuario;
           saveToken(loginnResponse.token);
           return true;

          }else{
            final resBody = jsonDecode(resp.body);

            return resBody['msg'];
          }     
    }

    Future<bool> isLoggedIn() async{

          final token = await this._storage.read(key: 'token');
        
          this.autenticando = true;
          
    
          var url = Uri.parse('${Environment.apiUrl}/login/renovarToken');
         
          final resp = await http.get(url, 
                headers: {
                  'Content-Type': 'application/json',
                  'x-token': token.toString()
                }
              );

          this.autenticando = false;

          if(resp.statusCode>=200 && resp.statusCode<299){

            final loginnResponse = loginResponseFromJson(resp.body);
          
            saveToken(loginnResponse.token);
            return true;

          }else{
            logout();
            return false;
          }  

    }


    Future saveToken(String token) async{
       return await _storage.write(key: 'token', value: token);
    }

    Future logout() async{
       await _storage.delete(key: 'token');
    }
    

}