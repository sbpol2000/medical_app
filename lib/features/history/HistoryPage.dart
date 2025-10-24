import 'package:flutter/material.dart';

class MedicalHistoryPage extends StatelessWidget {
  final List<Map<String, String>> medicalRecords = [
    {
      'title': 'Tratamiento: Suplemento de Hierro',
      'date': '16 de Octubre de 2023',
      'details': 'Recetado por Dr. López',
      'type': 'treatment',
    },
    {
      'title': 'Diagnóstico: Anemia leve',
      'date': '15 de Octubre de 2023',
      'details': 'Asociado a consulta con Dr. López',
      'type': 'diagnostic',
    },
    {
      'title': 'Consulta General - Dr. Ana López',
      'date': '15 de Octubre de 2023',
      'details': 'Motivo: Chequeo anual',
      'type': 'consult',
    },
    {
      'title': 'Resultados de Análisis de Sangre',
      'date': '10 de Octubre de 2023',
      'details': 'Ver resultados adjuntos',
      'type': 'lab_result',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Regresar',
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {},
        ),
        title: Text('Mi Historial Médico'),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: ListView.builder(
        itemCount: medicalRecords.length,
        itemBuilder: (context, index) {
          final record = medicalRecords[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              leading: Icon(
                _getIconForRecordType(record['type']!),
                color: _getIconColorForRecordType(record['type']!),
              ),
              title: Text(record['title']!),
              subtitle: Text('${record['date']} - ${record['details']}'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle tap
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle adding new record
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  IconData _getIconForRecordType(String type) {
    switch (type) {
      case 'treatment':
        return Icons.link;
      case 'diagnostic':
        return Icons.medical_services;
      case 'consult':
        return Icons.local_hospital;
      case 'lab_result':
        return Icons.local_laundry_service;
      default:
        return Icons.help;
    }
  }

  Color _getIconColorForRecordType(String type) {
    switch (type) {
      case 'treatment':
        return Colors.blue;
      case 'diagnostic':
        return Colors.orange;
      case 'consult':
        return Colors.green;
      case 'lab_result':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
