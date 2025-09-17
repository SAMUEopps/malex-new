import 'package:flutter/material.dart';

class AmountField extends StatelessWidget {
  final ValueChanged<double> onSaved;

  const AmountField({Key? key, required this.onSaved}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Amount',
        prefixText: 'KSh ',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (v) =>
          v == null || v.isEmpty || double.tryParse(v) == null ? 'Valid amount' : null,
      onSaved: (v) => onSaved(double.parse(v!)),
    );
  }
}