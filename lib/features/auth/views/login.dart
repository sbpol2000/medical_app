import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:medical_app/app/constants/colors.dart';
import 'package:medical_app/app/constants/navigate.dart';
import 'package:medical_app/features/auth/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();

  bool _obscure = true;
  bool _loading = false;
  String? _errorMessage;

  final _authRepository = AuthRepository(Supabase.instance.client);

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final form = _formKey.currentState;
    if (form == null) return;

    if (!form.validate()) return;

    setState(() {
      _loading = true;
      _errorMessage = null;
    });
    try {
      final res = await _authRepository.signInWithEmail(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text.trim(),
      );
      if (res.session == null || res.user == null) {
        // Muy raro si no lanzó excepción, pero por si acaso:
        throw const AuthException(
          'No se pudo iniciar sesión, intenta de nuevo.',
        );
      }
      // Si llegó aquí sin lanzar AuthException, el login fue correcto
      // (res.session suele venir no-nulo en éxito con password)
      NavigateTo.dashboard();
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Inicio de sesión exitoso')));
    } on AuthException catch (e) {
      // Errores de autenticación (credenciales inválidas, etc.)
      if (!mounted) return;
      setState(() => _errorMessage = e.message);

      // Manejo específico: email no confirmado
      if (e.message.toLowerCase().contains('email not confirmed')) {
        _showEmailNotConfirmedDialog();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(_errorMessage!)));
      }
    } catch (e) {
      // Otros errores inesperados
      if (!mounted) return;
      setState(() => _errorMessage = 'Ocurrió un error inesperado');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_errorMessage!)));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _resendConfirmationEmail() async {
    try {
      await Supabase.instance.client.auth.resend(
        type: OtpType.signup,
        email: _emailCtrl.text.trim(),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Correo de verificación reenviado. Revisa tu bandeja.'),
        ),
      );
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo reenviar el correo.')),
      );
    }
  }

  void _showEmailNotConfirmedDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Email no confirmado'),
          content: const Text(
            'Debes confirmar tu correo antes de iniciar sesión. Revisa tu bandeja o reenvía el correo de verificación.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cerrar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                _resendConfirmationEmail();
              },
              child: const Text('Reenviar correo'),
            ),
          ],
        );
      },
    );
  }

  //validacion de campo email
  String? _validateUserOrEmail(String? v) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return 'Ingresa tu correo o usuario';
    // Validación  de email
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    final usernameRegex = RegExp(r'^[a-zA-Z0-9._-]{3,}$');
    if (!emailRegex.hasMatch(value) && !usernameRegex.hasMatch(value)) {
      return 'Ingresa un correo válido o un usuario (mín. 3 caracteres)';
    }
    return null;
  }

  //validacion de campo password
  String? _validatePassword(String? v) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return 'Ingresa tu contraseña';
    if (value.length < 6) return 'Mínimo 6 caracteres';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 420,
                      minHeight: 0,
                    ),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Icono
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 16.0,
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/plusicon.jpg',
                                  width: 72,
                                  height: 72,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Bienvenido de vuelta',
                                  style: theme.textTheme.headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Campo usuario/correo
                          Text(
                            'Correo electrónico o nombre de usuario',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _emailCtrl,
                            focusNode: _emailFocus,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [
                              AutofillHints.username,
                              AutofillHints.email,
                            ],
                            decoration: InputDecoration(
                              labelText: 'Correo o usuario',
                              prefixIcon: Icon(Icons.person_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                            ),
                            onFieldSubmitted: (_) => _passFocus.requestFocus(),
                            validator: _validateUserOrEmail,
                            enabled: !_loading,
                          ),

                          const SizedBox(height: 16),

                          // Campo contraseña
                          Text(
                            'Contraseña',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _passCtrl,
                            focusNode: _passFocus,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.password],
                            obscureText: _obscure,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              prefixIcon: const Icon(Icons.lock_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              suffixIcon: IconButton(
                                tooltip: _obscure ? 'Mostrar' : 'Ocultar',
                                onPressed: _loading
                                    ? null
                                    : () =>
                                          setState(() => _obscure = !_obscure),
                                icon: Icon(
                                  _obscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            onFieldSubmitted: (_) => _submit(),
                            validator: _validatePassword,
                            enabled: !_loading,
                          ),

                          const SizedBox(height: 20),

                          // Botón login
                          SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _loading ? null : _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: _loading
                                  ? const SizedBox(
                                      height: 22,
                                      width: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Iniciar sesión',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // navegar a register
                          Center(
                            child: RichText(
                              text: TextSpan(
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium, // estilo base
                                children: [
                                  TextSpan(
                                    text: '¿Nuevo aquí? ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Registrate',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: colorBlue,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = _loading
                                          ? null
                                          : () {
                                              NavigateTo.register();
                                            },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
