import 'package:flutter/material.dart';
import 'package:medical_app/app/router/app_router.dart';

void main() {
  runApp(const MedicalApp());
}

class MedicalApp extends StatelessWidget {
  const MedicalApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'App Medica',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Fondo blanco global
      ),
      routerConfig: appRouter,
    );
  }
}
