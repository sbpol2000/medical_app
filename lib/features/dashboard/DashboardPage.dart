import 'package:flutter/material.dart';
import 'package:medical_app/app/constants/colors.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 20,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(color: Colors.black, width: 0.5),
        ),
        surfaceTintColor: Colors.transparent,
        leadingWidth: 56,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage('assets/usuario.jpg'),
          ),
        ),
        //saludo al usuario
        title: const Text(
          'Hola, Juan Pérez',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
        ),
        //icono de notificaciones
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black87),
            tooltip: 'Notificaciones',
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            Row(
              children: [
                Expanded(
                  child: _AgendarCitaCard(label: 'Agendar Cita', onTap: null),
                ),
                Expanded(
                  child: _RecetasCard(label: 'Mis recetas', onTap: null),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(children: [
               
              ],
            ),
          ],
        ),
      ),

      //barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // <- CLAVE con 4+ ítems
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        showUnselectedLabels: true,
        selectedItemColor: colorBlue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Citas',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'historial',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

class _AgendarCitaCard extends StatelessWidget {
  const _AgendarCitaCard({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      color: Colors.white,
      surfaceTintColor: Colors.transparent, // evita tinte en M3
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.black26, width: 0.5),
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

class _RecetasCard extends StatelessWidget {
  const _RecetasCard({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      color: Colors.white,
      surfaceTintColor: Colors.transparent, // evita tinte en M3
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.black26, width: 0.5),
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
                        Icons.description_outlined,
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
