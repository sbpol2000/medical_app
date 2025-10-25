import 'package:flutter/material.dart';
import 'package:medical_app/app/constants/colors.dart';
import 'package:medical_app/features/dashboard/widgets/card_action.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
                Expanded(child: CardAction(label: 'Agendar Cita', onTap: null)),
                Expanded(child: CardAction(label: 'Mis recetas', onTap: null)),
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
