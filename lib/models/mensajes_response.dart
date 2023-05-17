import 'dart:convert';

MensajeResponse mensajeResponseFromJson(String str) => MensajeResponse.fromJson(json.decode(str));

String mensajeResponseToJson(MensajeResponse data) => json.encode(data.toJson());

class MensajeResponse {
    bool ok;
    List<Mensaje> mensajes;

    MensajeResponse({
        required this.ok,
        required this.mensajes,
    });

    factory MensajeResponse.fromJson(Map<String, dynamic> json) => MensajeResponse(
        ok: json["ok"],
        mensajes: List<Mensaje>.from(json["mensajes"].map((x) => Mensaje.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
    };
}

class Mensaje {
    String para;
    String de;
    String mensaje;
    DateTime createdAt;
    DateTime updatedAt;

    Mensaje({
        required this.para,
        required this.de,
        required this.mensaje,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        para: json["para"],
        de: json["de"],
        mensaje: json["mensaje"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "para": para,
        "de": de,
        "mensaje": mensaje,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
