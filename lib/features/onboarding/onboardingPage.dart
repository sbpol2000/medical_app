import 'package:flutter/material.dart';
import 'onboarding_carousel.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icono
            Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
              child: Image.asset(
                'assets/medicalicon.png',
                width: 64,
                height: 64,
              ),
            ),

            //carusel
            const Expanded(child: Center(child: OnboardingCarousel())),

            //boton empezar
            Padding(
              padding: const EdgeInsets.only(
                bottom: 48.0,
                left: 24.0,
                right: 24.0,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Aquí puedes navegar a la pantalla principal o de login
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(
                      0,
                      122,
                      255,
                      100,
                    ), // Color azul
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ), // Esquinas redondeadas
                    ),
                  ),
                  child: const Text(
                    'Empezar',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
