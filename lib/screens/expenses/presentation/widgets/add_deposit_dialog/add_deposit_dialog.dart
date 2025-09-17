/* -------------------------------------------------------------------------- */
/*                               Dialog                                       */
/* -------------------------------------------------------------------------- */

import 'package:malex_new/screens/expenses/data/models/cash_deposit.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/add_deposit_dialog/date_field.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/add_deposit_dialog/time_field.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/shared/button_styles.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/shared/text_styles.dart';
import 'package:flutter/material.dart';

class AddDepositDialog {
  static Future<CashDeposit?> show(BuildContext context) async {
    return showDialog<CashDeposit>(
      context: context,
      builder: (_) => const _DepositDialogContent(),
    );
  }
}

class _DepositDialogContent extends StatefulWidget {
  const _DepositDialogContent();

  @override
  State<_DepositDialogContent> createState() => _DepositDialogContentState();
}

class _DepositDialogContentState extends State<_DepositDialogContent> {
  final _formKey = GlobalKey<FormState>();
  String _source = 'Boss';
  double _amount = 0;
  String? _notes;
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Add Cash Deposit', style: TextStyles.header),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _source,
                decoration: const InputDecoration(
                    labelText: 'Source', border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'Boss', child: Text('Boss')),
                  DropdownMenuItem(value: 'Sales', child: Text('Sales')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (v) => _source = v!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: 'KSh ',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.isEmpty || double.tryParse(v) == null
                        ? 'Valid number required'
                        : null,
                onSaved: (v) => _amount = double.parse(v!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                onSaved: (v) => _notes = v,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DateField(
                      label: 'Date',
                      date: _date,
                      onPick: (d) => setState(() => _date = d),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TimeField(
                      label: 'Time',
                      time: _time,
                      onPick: (t) => setState(() => _time = t),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: Navigator.of(context).pop,
                      child: const Text('Cancel')),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ButtonStyles.success,
                    child: const Text('Add Deposit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    final dateTime = DateTime(_date.year, _date.month, _date.day, _time.hour,
        _time.minute);
    Navigator.of(context).pop(CashDeposit(
      source: _source,
      amount: _amount,
      date: dateTime,
      notes: _notes,
    ));
  }
}