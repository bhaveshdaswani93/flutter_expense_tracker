import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  final void Function(Expense expense) onEditExpense;
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
    required this.onEditExpense,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          margin: Theme.of(context).cardTheme.margin,
          color: Theme.of(context).colorScheme.error,
        ),
        key: ValueKey(expenses[index]),
        child: ExpenseItem(expenses[index], onEditExpense: onEditExpense),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
      ),
    );
  }
}
