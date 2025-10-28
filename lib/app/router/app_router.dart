import 'package:go_router/go_router.dart';
import 'package:medical_app/app/constants/routes.dart';
import 'package:medical_app/app/services/navigate_service.dart';
import 'package:medical_app/features/appointments/views/RegistroCita.dart';
import 'package:medical_app/features/auth/views/login.dart';
import 'package:medical_app/features/auth/views/register.dart';
import 'package:medical_app/features/chat/views/ChatPage.dart';
import 'package:medical_app/features/dashboard/views/dashboard.dart';
import 'package:medical_app/features/onboarding/views/onboardingPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: NavigateService.navigatorKey,
  initialLocation: AppRoutes.dashboard,
  redirect: (context, state) {
    // Obtener la sesión de Supabase
    final session = Supabase.instance.client.auth.currentSession;

    // Si el usuario no está autenticado y está intentando acceder a rutas protegidas
    final isLoggingIn =
        state.uri.toString() == AppRoutes.login ||
        state.uri.toString() == AppRoutes.register;

    if (session == null && !isLoggingIn) {
      // Redirigir al login si no está autenticado y no está en las rutas de login/register
      return AppRoutes.login;
    }

    // Si el usuario está autenticado y está intentando ir a Login/Register, redirigir al Dashboard
    if (session != null && isLoggingIn) {
      return AppRoutes.dashboard;
    }

    return null; // Si no hay redirección, mantener la ruta actual
  },
  routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: AppRoutes.chat,
      builder: (context, state) => const ChatListPage(),
    ),
    GoRoute(
      path: AppRoutes.appointments,
      builder: (context, state) => const MedicalAppointmentsPage(),
    ),
    GoRoute(
      path: AppRoutes.dashboard,
      builder: (context, state) => const Dashboard(),
    ),
  ],
);
