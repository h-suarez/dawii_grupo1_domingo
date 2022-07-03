import 'package:dawii_grupo1_domingo/models/sede.dart';
import 'package:dawii_grupo1_domingo/services/sede/sedeService.dart';
import 'package:dawii_grupo1_domingo/views/screens.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class LstSedes extends StatefulWidget {
  @override
  State<LstSedes> createState() => _LstSedesState();
}

class _LstSedesState extends State<LstSedes> {
  Future<List<Sede>>? lstSedes = listarSedes();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Mantenimiento de sede',
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: FutureBuilder(
          future: lstSedes,
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: construirLSTSedes(snapshot.data),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return ListView(
                children: const <Widget>[
                  ListTile(
                    title: Text(
                      'Sin sede',
                      style: TextStyle(fontSize: 30),
                    ),
                  )
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'formSede'),
      ),
    );
  }

  List<Widget> construirLSTSedes(List<Sede> data) {
    List<Widget> sedes = [];
    for (var p in data) {
      sedes.add(ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: const Icon(Icons.account_balance, size: 40.0),
        title: Text(p.nombre, style: const TextStyle(fontSize: 30)),
        subtitle: Text(
          p.pais.nombre,
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormularioSede(
                sede: Sede(
                  idSede: p.idSede,
                  nombre: p.nombre,
                  direccion: p.direccion,
                  estado: p.estado,
                  fechaCreacion: p.fechaCreacion,
                  fechaRegistro: p.fechaRegistro,
                  codigoPostal: p.codigoPostal,
                  pais: p.pais,
                ),
              ),
            ),
          );
        },
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Colors.red,
          onPressed: () {
            eliminarSede(p.idSede!).then((resp) {
              Toast.show(
                resp,
                duration: Toast.lengthLong,
                gravity: Toast.bottom,
                backgroundColor: Colors.green,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              );
            }).whenComplete(
              () {
                onRefresh();
              },
            );
          },
        ),
      ));
    }
    return sedes;
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 2))
        .whenComplete(() => lstSedes = listarSedes());
    setState(() {});
  }
}
