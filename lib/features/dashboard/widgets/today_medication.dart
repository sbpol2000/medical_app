import 'package:flutter/material.dart';
import 'package:medical_app/app/constants/colors.dart';

class TodayMedication extends StatefulWidget {
  const TodayMedication({super.key});

  @override
  State<TodayMedication> createState() => _TodayMedicationState();
}

class _TodayMedicationState extends State<TodayMedication> {
  Widget buildMedicationItem({bool checked = false, String medication = ''}) {
    return Row(
      children: [
        Checkbox(
          value: checked,
          onChanged: (value) {},
          activeColor: colorBlue,
          side: BorderSide(color: Colors.grey.shade400, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        Text(medication),
      ],
    );
  }

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
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Column(
          children: [
            buildMedicationItem(
              checked: false,
              medication: 'Aspirina 100mg - 8:00 AM',
            ),
            Divider(
              height: 0,
              indent: 16,
              endIndent: 16,
              thickness: 0.5,
              color: Colors.grey.shade300,
            ),
            buildMedicationItem(
              checked: true,
              medication: 'Ibuprofeno 200mg - 9:00 AM',
            ),
            Divider(
              height: 0,
              indent: 16,
              endIndent: 16,
              thickness: 0.5,
              color: Colors.grey.shade300,
            ),
            buildMedicationItem(
              checked: true,
              medication: 'Paracetamol 500mg - 10:00 AM',
            ),
          ],
        ),
      ),
    );
  }
}
