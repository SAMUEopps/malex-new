import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeRow extends StatelessWidget {
  final DateTime date;
  final TimeOfDay time;
  final ValueChanged<DateTime> onDate;
  final ValueChanged<TimeOfDay> onTime;

  const DateTimeRow({
    Key? key,
    required this.date,
    required this.time,
    required this.onDate,
    required this.onTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Date',
              border: OutlineInputBorder(),
            ),
            controller: TextEditingController(text: DateFormat('yyyy-MM-dd').format(date)),
            readOnly: true,
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) onDate(picked);
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Time',
              border: OutlineInputBorder(),
            ),
            controller: TextEditingController(text: time.format(context)),
            readOnly: true,
            onTap: () async {
              final picked = await showTimePicker(context: context, initialTime: time);
              if (picked != null) onTime(picked);
            },
          ),
        ),
      ],
    );
  }
}