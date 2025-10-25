import 'package:go_router/go_router.dart';
import 'package:medical_app/app/constants/routes.dart';
import 'package:medical_app/app/services/navigate_service.dart';
import 'package:medical_app/features/appointments/views/RegistroCita.dart';
import 'package:medical_app/features/auth/views/login.dart';
import 'package:medical_app/features/auth/views/register.dart';
import 'package:medical_app/features/chat/views/ChatPage.dart';
import 'package:medical_app/features/dashboard/views/dashboard.dart';
import 'package:medical_app/features/onboarding/views/onboardingPage.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: NavigateService.navigatorKey,
  initialLocation: AppRoutes.onboarding,
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
