import 'dart:convert';

import 'package:dawii_grupo1_domingo/models/pais.dart';

Sede sedeFromJson(String str) => Sede.fromJson(json.decode(str));

String sedeToJson(Sede data) => json.encode(data.toJson());

//* Decodificar el listado de sedes
List<Sede> listaSedeFromJson(String str) =>
    List<Sede>.from(json.decode(str).map((x) => Sede.fromJson(x)));

//* Convertir los valores recibidos a JSON
String sedeToJsonR(Map data) => json.encode(data);
//?

class Sede {
  int? idSede;
  String nombre;
  String direccion;
  int estado;
  DateTime fechaCreacion;
  DateTime? fechaRegistro;
  String codigoPostal;
  Pais pais;

  Sede({
    this.idSede,
    required this.nombre,
    required this.direccion,
    required this.estado,
    required this.fechaCreacion,
    this.fechaRegistro,
    required this.codigoPostal,
    required this.pais,
  });

  factory Sede.fromJson(Map<String, dynamic> json) => Sede(
        idSede: json["idSede"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        estado: json["estado"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaRegistro: DateTime.parse(json["fechaRegistro"]),
        codigoPostal: json["codigoPostal"],
        pais: Pais.fromJson(json["pais"]),
      );

  Map<String, dynamic> toJson() => {
        "idSede": idSede,
        "nombre": nombre,
        "direccion": direccion,
        "estado": estado,
        "fechaCreacion":
            "${fechaCreacion.year.toString().padLeft(4, '0')}-${fechaCreacion.month.toString().padLeft(2, '0')}-${fechaCreacion.day.toString().padLeft(2, '0')}",
        "fechaRegistro": fechaRegistro,
        "codigoPostal": codigoPostal,
        "pais": pais.toJson(),
      };
}
