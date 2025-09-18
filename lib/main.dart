import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:malex_new/app/app.dart';

void main() {
  runApp(
    const ProviderScope( 
      child: ExpenseTrackerApp(),
    ),
  );
}
