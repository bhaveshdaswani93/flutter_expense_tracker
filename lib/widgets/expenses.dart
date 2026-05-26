import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/add_expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    // TODO: implement createState
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      useSafeArea: true,
      builder: (BuildContext ctx) => AddExpense(onAddExpense: addExpense),
    );
  }

  addExpense(Expense expense) {
    setState(() {
      _expensesData.add(expense);
    });
  }

  removeExpense(Expense expense) {
    final index = _expensesData.indexOf(expense);

    setState(() {
      _expensesData.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Expense Deleted"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _expensesData.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  final List<Expense> _expensesData = [
    Expense(
      title: "Flutter Course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Cinema",
      amount: 15.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: "Pizza",
      amount: 9.99,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _expensesData),
          Expanded(
            child: ExpensesList(
              expenses: _expensesData,
              onRemoveExpense: removeExpense,
            ),
          ),
        ],
      ),
    );
  }
}
