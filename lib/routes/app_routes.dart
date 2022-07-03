import 'package:dawii_grupo1_domingo/views/v_lst_sedes.dart';
import 'package:flutter/material.dart';
import 'package:dawii_grupo1_domingo/views/screens.dart';

class AppRoutes {
  static const initalRoute = 'lstSede';
  static Map<String, Widget Function(BuildContext)> routes = {
    'lstSede': (BuildContext context) => LstSedes(),
    'formSede': (BuildContext context) => FormularioSede(),
  };
}
