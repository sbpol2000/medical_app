import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _medicationReminders = true;
  bool _appointmentsReminders = true;
  bool _useFaceID = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Section
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('lo que vaya'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Maria Garcia',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Edit personal info action
                      },
                      child: Text(
                        'Editar información personal',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            // General Settings
            Text(
              'GENERAL',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Idioma'),
              subtitle: Text('Español'),
              onTap: () {
                // Language change action
              },
            ),
            ListTile(
              leading: Icon(Icons.spa),
              title: Text('Unidades'),
              subtitle: Text('Sistema métrico'),
              onTap: () {
                // Units change action
              },
            ),
            Divider(),
            // Notifications Section
            Text(
              'NOTIFICACIONES',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              title: Text('Permitir notificaciones'),
            ),
            SwitchListTile(
              value: _medicationReminders,
              onChanged: (value) {
                setState(() {
                  _medicationReminders = value;
                });
              },
              title: Text('Recordatorios de medicamentos'),
            ),
            SwitchListTile(
              value: _appointmentsReminders,
              onChanged: (value) {
                setState(() {
                  _appointmentsReminders = value;
                });
              },
              title: Text('Próximas citas'),
            ),
            Divider(),
            // Security and Privacy Section
            Text(
              'SEGURIDAD Y PRIVACIDAD',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Cambiar contraseña'),
              onTap: () {
                // Change password action
              },
            ),
            SwitchListTile(
              value: _useFaceID,
              onChanged: (value) {
                setState(() {
                  _useFaceID = value;
                });
              },
              title: Text('Usar Face ID para iniciar sesión'),
            ),
            ListTile(
              leading: Icon(Icons.shield),
              title: Text('Política de Privacidad'),
              onTap: () {
                // Privacy policy action
              },
            ),
            Divider(),
            // Support Section
            Text(
              'SOPORTE',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Ayuda y soporte'),
              onTap: () {
                // Help and support action
              },
            ),
            ListTile(
              leading: Icon(Icons.article),
              title: Text('Términos y condiciones'),
              onTap: () {
                // Terms and conditions action
              },
            ),
            Divider(),
            // Log Out Button
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Log out action
              },
              child: Text('Cerrar sesión'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
