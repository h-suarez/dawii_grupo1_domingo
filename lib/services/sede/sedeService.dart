import 'dart:convert';
import 'package:dawii_grupo1_domingo/models/sede.dart';
import 'package:dawii_grupo1_domingo/utils/config.dart';
import 'package:http/http.dart' as http;

Future<List<Sede>> listarSedes() async {
  Uri ruta = Uri.parse(RUTA + '/sede');
  http.Response response = await http.get(ruta);
  List<Sede> lstSedes = [];
  List<Sede> decoSedes = listaSedeFromJson(response.body);
  for (var i in decoSedes) {
    lstSedes.add(Sede(
      nombre: i.nombre,
      direccion: i.direccion,
      estado: i.estado,
      fechaCreacion: i.fechaCreacion,
      codigoPostal: i.codigoPostal,
      pais: i.pais,
    ));
  }
  return lstSedes;
}

Future<String> registrarSede(Map sede) async {
  String msg = '';
  try {
    Uri ruta = Uri.parse(RUTA + '/sede');
    var body = sedeToJsonR(sede);
    http.Response response = await http.post(
      ruta,
      headers: HEARDERS,
      body: body,
    );
    Map msgdec = jsonDecode(response.body);
    msg = msgdec["msg"];
    return msg;
  } catch (e) {
    // ignore: avoid_print
    print('Excepcion: $e - ' + msg);
  }
  return msg;
}

Future<String> actualizarSede(Map sede) async {
  String msg = '';
  try {
    Uri ruta = Uri.parse(RUTA + '/sede');
    var body = sedeToJsonR(sede);
    http.Response response = await http.put(
      ruta,
      headers: HEARDERS,
      body: body,
    );
    Map msgdec = jsonDecode(response.body);
    msg = msgdec["msg"];
    return msg;
  } catch (e) {
    // ignore: avoid_print
    print('Excepcion: $e - ' + msg);
  }
  return msg;
}
