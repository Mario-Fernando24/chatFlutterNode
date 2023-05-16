import 'dart:convert';

import 'package:chatmongoflutter/models/usuarios.dart';

UsuarioResponse usuarioResponseFromJson(String str) => UsuarioResponse.fromJson(json.decode(str));

String usuarioResponseToJson(UsuarioResponse data) => json.encode(data.toJson());

class UsuarioResponse {
    bool ok;
    List<Usuario> usuario;

    UsuarioResponse({
        required this.ok,
        required this.usuario,
    });

    factory UsuarioResponse.fromJson(Map<String, dynamic> json) => UsuarioResponse(
        ok: json["ok"],
        usuario: List<Usuario>.from(json["usuario"].map((x) => Usuario.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": List<dynamic>.from(usuario.map((x) => x.toJson())),
    };
}


