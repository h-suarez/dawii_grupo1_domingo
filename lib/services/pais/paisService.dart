import 'package:dawii_grupo1_domingo/models/pais.dart';
import 'package:dawii_grupo1_domingo/utils/config.dart';
import 'package:http/http.dart' as http;

Future<List<Pais>> listarPaises() async {
  Uri ruta = Uri.parse(RUTA + '/util/pais');
  http.Response response = await http.get(ruta);
  List<Pais> lstCategorias = [];
  List<Pais> decoCategorias = listaPaisFromJson(response.body);
  for (var i in decoCategorias) {
    lstCategorias.add(Pais(idPais: i.idPais, iso: i.iso, nombre: i.nombre));
  }
  return lstCategorias;
}
