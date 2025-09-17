
import 'package:flutter/material.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/header/filter_button.dart';
import 'package:malex_new/screens/expenses/presentation/widgets/shared/text_styles.dart';
class Header extends StatelessWidget {
  final String title;
  final VoidCallback? onFilter;
  final Widget actionButton;

  const Header({
    required this.title,
    required this.onFilter,
    required this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyles.header),
        Row(children: [
          FilterButton(onTap: onFilter),
          const SizedBox(width: 12),
          actionButton,
        ]),
      ],
    );
  }
}
