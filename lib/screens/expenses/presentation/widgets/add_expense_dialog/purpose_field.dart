import 'package:flutter/material.dart';

class PurposeField extends StatelessWidget {
  final String initial;
  final ValueChanged<String> onChanged;

  const PurposeField({Key? key, required this.initial, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: initial,
      decoration: const InputDecoration(labelText: 'Purpose', border: OutlineInputBorder()),
      items: const [
        DropdownMenuItem(value: 'Purchases', child: Text('Purchases')),
        DropdownMenuItem(value: 'Transport', child: Text('Transport')),
        DropdownMenuItem(value: 'Meals', child: Text('Meals')),
        DropdownMenuItem(value: 'Utilities', child: Text('Utilities')),
        DropdownMenuItem(value: 'Other', child: Text('Other')),
      ],
      onChanged: (v) => onChanged(v!),
      validator: (v) => v == null ? 'Required' : null,
    );
  }
}