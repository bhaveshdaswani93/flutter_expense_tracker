import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

final kColorScheme = ColorScheme.fromSeed(seedColor: Colors.purple);
final kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.purple,
  brightness: Brightness.dark,
);

ThemeData _buildTheme(ColorScheme colorScheme, ThemeData base) {
  return base.copyWith(
    colorScheme: colorScheme,
    cardTheme: CardThemeData(
      color: colorScheme.primaryContainer,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),
    ),
    textTheme: base.textTheme.copyWith(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSecondaryContainer,
        fontSize: 18,
      ),
    ),
  );
}

void main() {
  runApp(
    MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: _buildTheme(kDarkColorScheme, ThemeData.dark()),
      theme: _buildTheme(kColorScheme, ThemeData()).copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
      ),
      home: const Expenses(),
    ),
  );
}
