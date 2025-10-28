import 'package:flutter/material.dart';
import 'package:medical_app/app/router/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medical_app/app/constants/configurations.dart';

// void main() {
//   runApp(const MedicalApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: Configurations.supabaseUrl,
    anonKey: Configurations.supabaseAnonKey,
  );
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
