import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _supabaseClient;

  AuthRepository(this._supabaseClient);

  // Iniciar sesión
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response;
  }

  // Registrarse
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await _supabaseClient.auth.signUp(
      email: email,
      password: password,
    );
    return response;
  }

  // Cerrar sesión
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  // Obtener la sesión actual
  Session? get currentSession => _supabaseClient.auth.currentSession;

  // Listener para el cambio de estado de autenticación
  Stream<AuthState> get authStateChanges =>
      _supabaseClient.auth.onAuthStateChange;
}
