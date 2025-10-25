import 'package:flutter/material.dart';

class CardAction extends StatelessWidget {
  const CardAction({super.key, this.onTap, this.label = 'Agendar Cita'});
  final Function()? onTap;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      color: Colors.white,
      surfaceTintColor: Colors.transparent, // evita tinte en M3
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: const Color.fromARGB(66, 168, 167, 167),
          width: 0.5,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icono "calendario + lápiz"
              SizedBox(
                width: 40,
                height: 40,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: Icon(
                        Icons.calendar_today_outlined,
                        size: 40,
                        color: Color.fromRGBO(0, 122, 255, 100), // C,
                      ),
                    ),
                    Positioned(
                      right: 2,
                      bottom: 0,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 122, 255, 100),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit, // lápiz
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
