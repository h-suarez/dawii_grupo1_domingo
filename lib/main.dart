import 'package:dawii_grupo1_domingo/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initalRoute,
      theme: ThemeData.dark(),
      title: 'Sistema de Delivery',
      routes: AppRoutes.routes,
    );
  }
}
