import 'package:go_router/go_router.dart';
import 'package:medical_app/features/appointments/RegistroCita.dart';
import 'package:medical_app/features/auth/views/login.dart';
import 'package:medical_app/features/auth/views/register.dart';
import 'package:medical_app/features/chat/ChatPage.dart';
import 'package:medical_app/features/onboarding/onboardingPage.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const OnboardingPage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(path: '/chat', builder: (context, state) => const ChatListPage()),
    GoRoute(
      path: '/appointments',
      builder: (context, state) => const MedicalAppointmentsPage(),
    ),
  ],
);
