import 'package:expense_tracker/models/expense.dart';
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
  String? _selectedDate;
  Category _selectedCategory = Category.work;

  void handleCancel() {
    Navigator.pop(context);
  }

  void _handleSave() {
    print(_titleController.text);
    print(_amountController.text);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> showDatePickerOption() async {
    DateTime firstDate = DateTime.now().subtract(Duration(days: 365));
    DateTime lastDate = DateTime.now().add(Duration(days: 365));

    DateTime? chosenDateTime = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (chosenDateTime == null) {
      return;
    }

    setState(() {
      _selectedDate = formatter.format(chosenDateTime);
    });
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      label: Text('Amount'),
                      prefixText: '\$',
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: false,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(_selectedDate ?? "Select Date"),
                      IconButton(
                        onPressed: showDatePickerOption,
                        icon: Icon(Icons.calendar_month),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                DropdownButton(
                  items: Category.values.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(
                        category.name.toString().toUpperCase(),
                      ),
                    );
                  }).toList(),
                  value: _selectedCategory,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                Spacer(),
                TextButton(
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
