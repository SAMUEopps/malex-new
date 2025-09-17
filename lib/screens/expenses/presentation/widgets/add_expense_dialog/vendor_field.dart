import 'package:flutter/material.dart';

class VendorField extends StatelessWidget {
  final ValueChanged<String> onSaved;

  const VendorField({Key? key, required this.onSaved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Vendor / Employee',
        border: OutlineInputBorder(),
      ),
      validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
      onSaved: (v) => onSaved(v!.trim()),
    );
  }
}