import 'package:flutter/material.dart';
import 'features/onboarding/onboardingPage.dart';
import 'features/auth/login.dart';
import 'features/auth/register.dart';
import 'features/auth/register.dart';
import 'features/chat/ChatPage.dart';
import 'features/appointments/RegistroCita.dart';

void main() {
  runApp(const MedicalApp());
}

class MedicalApp extends StatelessWidget {
  const MedicalApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Medica',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        scaffoldBackgroundColor: Colors.white, // Fondo blanco global
      ),
      home: MedicalAppointmentsPage(),
    );
  }
}
