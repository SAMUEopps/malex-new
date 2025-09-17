import 'package:flutter/material.dart';
import 'package:malex_new/models/expense.dart';
import 'amount_field.dart';
import 'datetime_row.dart';
import 'notes_field.dart';
import 'purpose_field.dart';
import 'vendor_field.dart';

class ExpenseDialogContent extends StatefulWidget {
  const ExpenseDialogContent({Key? key}) : super(key: key);

  @override
  State<ExpenseDialogContent> createState() => _ExpenseDialogContentState();
}

class _ExpenseDialogContentState extends State<ExpenseDialogContent> {
  final _formKey = GlobalKey<FormState>();

  String? _purpose;
  double _amount = 0;
  String? _vendor;
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  String? _notes;

  @override
  void initState() {
    super.initState();
    _purpose = 'Purchases';          // default selection
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Add Expense', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 16),

                PurposeField(
                  initial: _purpose!,
                  onChanged: (v) => _purpose = v,
                ),
                const SizedBox(height: 16),

                AmountField(onSaved: (v) => _amount = v),
                const SizedBox(height: 16),

                VendorField(onSaved: (v) => _vendor = v),
                const SizedBox(height: 16),

                DateTimeRow(
                  date: _date,
                  time: _time,
                  onDate: (d) => _date = d,
                  onTime: (t) => _time = t,
                ),
                const SizedBox(height: 16),

                NotesField(onSaved: (v) => _notes = v),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: Navigator.of(context).pop, child: const Text('Cancel')),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3498DB),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Save Expense'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final dateTime = DateTime(
      _date.year,
      _date.month,
      _date.day,
      _time.hour,
      _time.minute,
    );

    /*Navigator.of(context).pop(Expense(
      //amount: _amount,
     // date: dateTime,
     // description: _purpose!,       // we use purpose as description
     // vendor: _vendor ?? '',
      //category: _purpose!,          // same value for category
     // paymentMethod: 'Cash',        // default – change if you have dropdown
    )*/
    
  }
}