import 'dart:convert';

Pais paisFromJson(String str) => Pais.fromJson(json.decode(str));

String paisToJson(Pais data) => json.encode(data.toJson());

List<Pais> listaPaisFromJson(String str) =>
    List<Pais>.from(json.decode(str).map((x) => Pais.fromJson(x)));

class Pais {
  int idPais;
  String iso;
  String nombre;

  Pais({
    required this.idPais,
    required this.iso,
    required this.nombre,
  });

  factory Pais.fromJson(Map<String, dynamic> json) => Pais(
        idPais: json["idPais"],
        iso: json["iso"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "idPais": idPais,
        "iso": iso,
        "nombre": nombre,
      };
}
