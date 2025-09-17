
import 'package:flutter/material.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/shared/button_styles.dart';
class FilterButton extends StatelessWidget {
  final VoidCallback? onTap;

  const FilterButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap ?? () {},
      icon: const Icon(Icons.filter_list, size: 16),
      label: const Text('Filter'),
      style: ButtonStyles.outlined,
    );
  }
}