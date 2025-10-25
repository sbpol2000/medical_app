import 'package:flutter/material.dart';

class MedicalAppointmentsPage extends StatefulWidget {
  const MedicalAppointmentsPage({super.key, this.borderRadius = 14});
  final double borderRadius;

  @override
  State<MedicalAppointmentsPage> createState() =>
      _AppointmentRegisterPageState();
}

class _AppointmentRegisterPageState extends State<MedicalAppointmentsPage> {
  // Mock de datos
  final Map<String, List<String>> _data = const {
    'Medicina General': ['Dra. Ana Pérez', 'Dr. Luis Rojas'],
    'Pediatría': ['Dra. Carla Díaz', 'Dr. Pedro Montes'],
    'Cardiología': ['Dr. Juan Torres'],
  };

  String? _specialty;
  String? _doctor;

  DateTime _selectedDate = DateTime.now();
  String? _selectedTime; // “HH:mm”
  final _notesCtrl = TextEditingController();

  // Slots de ejemplo
  final List<String> _timeSlots = const [
    '09:00',
    '10:00',
    '11:00',
    '14:00',
    '15:00',
    '16:00',
  ];

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  bool _isSlotDisabled(String slot) {
    // Ejemplo: deshabilitar 15:00 y todo lo pasado de hoy (si la fecha seleccionada es hoy)
    if (slot == '15:00') return true;

    if (_isSameDate(_selectedDate, DateTime.now())) {
      final now = TimeOfDay.now();
      final parts = slot.split(':');
      final h = int.parse(parts[0]);
      final m = int.parse(parts[1]);
      final slotTod = TimeOfDay(hour: h, minute: m);
      if (_compareTimeOfDay(slotTod, now) <= 0) return true; // pasado o igual
    }
    return false;
  }

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  int _compareTimeOfDay(TimeOfDay a, TimeOfDay b) {
    if (a.hour != b.hour) return a.hour.compareTo(b.hour);
    return a.minute.compareTo(b.minute);
    // <0: a < b, 0: igual, >0: a > b
  }

  void _confirm() {
    if (_specialty == null || _doctor == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa especialidad, médico y hora.')),
      );
      return;
    }
    // lógica  de guardado
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Cita confirmada: $_specialty con $_doctor el '
          '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year} a las $_selectedTime',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final doctors = _specialty == null
        ? const <String>[]
        : (_data[_specialty] ?? const []);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Regresar',
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {},
        ),
        centerTitle: true,
        title: const Text('Agendar Cita'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Especialidad
              Text(
                'Especialidad',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _specialty,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'Seleccionar especialidad',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _data.keys
                    .map(
                      (s) => DropdownMenuItem<String>(value: s, child: Text(s)),
                    )
                    .toList(),
                onChanged: (v) {
                  setState(() {
                    _specialty = v;
                    _doctor = null; // reset médico
                  });
                },
              ),

              const SizedBox(height: 16),

              // Médico
              Text(
                'Médico',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _doctor,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'Seleccionar médico',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: doctors
                    .map(
                      (d) => DropdownMenuItem<String>(value: d, child: Text(d)),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _doctor = v),
              ),

              const SizedBox(height: 20),

              // Fecha
              Text(
                'Fecha',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  border: Border.all(color: scheme.outline, width: 1.2),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: CalendarDatePicker(
                  currentDate: DateTime.now(),
                  initialDate: _selectedDate,
                  firstDate: DateTime.now().subtract(const Duration(days: 0)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  onDateChanged: (d) => setState(() {
                    _selectedDate = d;
                    _selectedTime = null; // reset hora al cambiar fecha
                  }),
                ),
              ),

              const SizedBox(height: 20),

              // Hora
              Text(
                'Hora',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _timeSlots.map((slot) {
                  final disabled = _isSlotDisabled(slot);
                  final selected = _selectedTime == slot;

                  Color bg;
                  Color fg;
                  BorderSide side;

                  if (disabled) {
                    bg = scheme.surfaceContainerHighest;
                    fg = scheme.onSurfaceVariant.withValues(alpha: 0.5);
                    side = BorderSide(
                      color: scheme.outline.withValues(alpha: 0.5),
                    );
                  } else if (selected) {
                    bg = scheme.primary;
                    fg = scheme.onPrimary;
                    side = BorderSide(color: scheme.primary);
                  } else {
                    bg = scheme.surface;
                    fg = scheme.onSurface;
                    side = BorderSide(color: scheme.outline);
                  }

                  return InkWell(
                    onTap: disabled
                        ? null
                        : () => setState(() => _selectedTime = slot),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 96,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: bg,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: side,
                        ),
                      ),
                      child: Text(
                        slot,
                        style: TextStyle(
                          color: fg,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Notas
              Text(
                'Notas o síntomas',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _notesCtrl,
                minLines: 3,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Describa brevemente el motivo de su visita...',
                  alignLabelWithHint: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Botón confirmar
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _confirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(0, 122, 255, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                    ),
                  ),
                  child: const Text(
                    'Confirmar Cita',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
