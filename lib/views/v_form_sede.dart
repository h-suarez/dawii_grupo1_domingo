import 'package:dawii_grupo1_domingo/models/pais.dart';
import 'package:dawii_grupo1_domingo/models/sede.dart';
import 'package:dawii_grupo1_domingo/services/pais/paisService.dart';
import 'package:dawii_grupo1_domingo/services/sede/sedeService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class FormularioSede extends StatefulWidget {
  final Sede? sede;
  const FormularioSede({this.sede});

  @override
  State<FormularioSede> createState() => _FormularioSedeState();
}

class _FormularioSedeState extends State<FormularioSede> {
  //* Formulario de sede
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  //* Campos
  final TextEditingController nomController = TextEditingController();
  final TextEditingController direcController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController codPostController = TextEditingController();
  var paisSeleccionado = 0;
  var estadoSeleccionado = 0;
  var fecCre = '';
  var fecReg = '';
  var idSede = 0;

  @override
  void initState() {
    if (widget.sede != null) {
      idSede = widget.sede!.idSede!;
      nomController.text = widget.sede!.nombre;
      direcController.text = widget.sede!.direccion;
      var formatFecCre = widget.sede!.fechaCreacion;
      var formatterFecCre = DateFormat('yyyy-MM-dd');
      fecCre = formatterFecCre.format(formatFecCre);
      // print("fe.CRE: ${fecCre}");
      fechaController.text = fecCre;
      var formatFecReg = widget.sede!.fechaRegistro;
      var formatterFecReg = DateFormat('yyyy-MM-dd hh:mm:ss');
      fecReg = formatterFecReg.format(formatFecReg!);
      // print("fe.REG: ${fecReg}");
      codPostController.text = widget.sede!.codigoPostal;
      paisSeleccionado = widget.sede!.pais.idPais;
      estadoSeleccionado = widget.sede!.estado;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    Map<String, dynamic> formValues = {
      'id': widget.sede?.idSede,
      'nombre': nomController.text,
      'direccion': direcController.text,
      'estado': 1,
      'fechaCreacion': fechaController.text,
      'codigoPostal': codPostController.text,
      'pais': {},
    };
    Future<List<Pais>>? lstPaises = listarPaises();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de sede'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Form(
          key: myFormKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nomController,
                autofocus: false,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  formValues['nombre'] = value.toString();
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  hintText: 'Ingrese nombre de sede',
                  labelText: 'Nombre sede',
                ),
                validator: (value) {
                  if (value == null) return 'Este campo es requerido';
                  return value.isEmpty ? 'Falta el nombre' : null;
                },
              ),
              TextFormField(
                controller: direcController,
                autofocus: false,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  formValues['direccion'] = value.toString();
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  hintText: 'Ingrese la dirección',
                  labelText: 'Dirección',
                ),
                validator: (value) {
                  if (value == null) return 'Este campo es requerido';
                  return value.isEmpty ? 'Falta la dirección' : null;
                },
              ),
              TextFormField(
                controller: codPostController,
                autofocus: false,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  formValues['codigoPostal'] = value.toString();
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  hintText: 'Ingrese el código postal',
                  labelText: 'Código postal',
                ),
                validator: (value) {
                  if (value == null) return 'Este campo es requerido';
                  return value.length != 5 || value.isEmpty
                      ? 'Ingrese 5 digitos'
                      : null;
                },
              ),
              TextFormField(
                controller: fechaController,
                autofocus: false,
                keyboardType: TextInputType.datetime,
                onChanged: (value) {
                  formValues['fechaCreacion'] = value.toString();
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  hintText: 'Ingrese la fecha de creación',
                  labelText: 'Fecha de Creación',
                ),
                validator: (value) {
                  if (value == null) return 'Este campo es requerido';
                  return value.isEmpty ? 'Falta la fecha' : null;
                },
              ),
              const SizedBox(height: 12),
              FutureBuilder(
                future: lstPaises,
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return construirDropsPaises(snapshot.data);
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return DropdownButtonFormField<int>(
                      value: 0,
                      items: const [
                        DropdownMenuItem(
                            value: 0, child: Text('Seleccione pais')),
                      ],
                      onChanged: (val) {},
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                value: estadoSeleccionado,
                items: const [
                  DropdownMenuItem(value: 0, child: Text('Inactivo')),
                  DropdownMenuItem(value: 1, child: Text('Activo')),
                ],
                onChanged: (val) {
                  estadoSeleccionado = val!;
                },
                validator: (value) {
                  if (value == null) return 'Este campo es requerido';
                  return value > 1 ? 'Seleccione el estado' : null;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                child: SizedBox(
                  width: double.infinity,
                  child: widget.sede != null
                      ? const Text(
                          'ACTUALIZAR',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        )
                      : const Text(
                          'GUARDAR',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                ),
                onPressed: () {
                  formValues['estado'] = estadoSeleccionado;
                  formValues['pais'] = {'idPais': paisSeleccionado};
                  // print(formValues);
                  if (!myFormKey.currentState!.validate()) {
                    Toast.show(
                      'Campos no validos',
                      duration: Toast.lengthLong,
                      gravity: Toast.bottom,
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    );
                    return;
                  }
                  if (widget.sede != null) {
                    formValues['idSede'] = idSede;
                    formValues['fechaRegistro'] = fecReg;
                    // print(formValues);
                    actualizarSede(formValues)
                        .then((resp) => {
                              Toast.show(
                                resp,
                                duration: Toast.lengthLong,
                                gravity: Toast.bottom,
                                backgroundColor: Colors.green,
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              )
                            })
                        .whenComplete(
                          () => Navigator.pop(context),
                        );
                  } else {
                    registrarSede(formValues).then((resp) {
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
                      () => Navigator.pop(context),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<int>> constListPaises(List<Pais> data) {
    List<DropdownMenuItem<int>> paises = [];
    paises.add(const DropdownMenuItem<int>(
      value: 0,
      child: Text('Seleccione pais'),
    ));
    for (var p in data) {
      paises.add(DropdownMenuItem<int>(
        value: p.idPais,
        child: Text(p.nombre),
      ));
    }
    return paises;
  }

  DropdownButtonFormField construirDropsPaises(List<Pais> data) {
    DropdownButtonFormField selecPaises = DropdownButtonFormField(
      value: paisSeleccionado,
      items: constListPaises(data),
      onChanged: (value) {
        paisSeleccionado = value;
        // print(paisSeleccionado);
      },
      validator: (value) {
        if (value == null) return 'Este campo es requerido';
        return value == 0 ? 'Seleccione el pais' : null;
      },
    );
    return selecPaises;
  }
}
