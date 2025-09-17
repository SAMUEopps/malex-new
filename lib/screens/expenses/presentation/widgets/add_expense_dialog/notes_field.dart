import 'package:flutter/material.dart';

class NotesField extends StatelessWidget {
  final ValueChanged<String?> onSaved;

  const NotesField({Key? key, required this.onSaved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Notes (optional)',
        border: OutlineInputBorder(),
      ),
      maxLines: 2,
      onSaved: onSaved,
    );
  }
}