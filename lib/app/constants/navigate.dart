import 'package:go_router/go_router.dart';
import 'package:medical_app/app/constants/routes.dart';
import 'package:medical_app/app/services/navigate_service.dart';

class NavigateTo {
  static void onboarding() {
    NavigateService.navigatorKey.currentContext?.go(AppRoutes.onboarding);
  }
  static void login() {
    NavigateService.navigatorKey.currentContext?.go(AppRoutes.login);
  }
  static void register() {
    NavigateService.navigatorKey.currentContext?.go(AppRoutes.register);
  }
  static void chat() {
    NavigateService.navigatorKey.currentContext?.go(AppRoutes.chat);
  }
  static void appointments() {
    NavigateService.navigatorKey.currentContext?.go(AppRoutes.appointments);
  }
  static void dashboard() {
    NavigateService.navigatorKey.currentContext?.go(AppRoutes.dashboard);
  }
}
