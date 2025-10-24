import 'package:flutter/material.dart';

class OnboardingCarousel extends StatefulWidget {
  const OnboardingCarousel({Key? key}) : super(key: key);

  @override
  State<OnboardingCarousel> createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Tu salud,en tus manos',
      'desc': 'Gestiona tus citas, historial y más desde un solo lugar.',
      'image': 'assets/doctora.png',
    },
    {
      'title': 'Citas rápidas',
      'desc': 'Reserva y administra tus citas médicas fácilmente.',
      'image': 'assets/citamedica.jpg',
    },
    {
      'title': 'Historial seguro',
      'desc': 'Accede a tu historial médico de forma segura y privada.',
      'image': 'assets/historiaclinica.jpeg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 400,
          child: PageView.builder(
            controller: _controller,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final page = _pages[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(page['image']!, height: 200),
                  const SizedBox(height: 40),
                  Text(
                    page['title']!,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    page['desc']!,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _pages.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
