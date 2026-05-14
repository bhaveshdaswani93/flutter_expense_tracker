import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void handleCancel() {
    Navigator.pop(context);
  }

  void _handleSave() {
    print(_titleController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "Add Expense",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(label: Text("Title")),
              keyboardType: TextInputType.text,
              controller: _titleController,
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                label: Text('Amount'),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: false),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: handleCancel,
                  child: Text('Cancel'),
                ),
                SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: _handleSave,
                  child: Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
