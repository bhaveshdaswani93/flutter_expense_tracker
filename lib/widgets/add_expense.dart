import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  final void Function(Expense) onAddExpense;

  const AddExpense({super.key, required this.onAddExpense});

  @override
  State<AddExpense> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.work;

  void handleCancel() {
    Navigator.pop(context);
  }

  void _handleSave() {
    final enteredTitle = _titleController.text.trim();
    final enteredAmount = double.tryParse(_amountController.text);

    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    final dateIsInvalid = _selectedDate == null;
    final titleIsInvalid = enteredTitle.isEmpty;
    final formIsInvalid = amountIsInvalid || dateIsInvalid || titleIsInvalid;

    if (formIsInvalid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Invalid Input"),
          content: Text(
            "Please make sure to enter valid title, amount and date.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text("Okay"),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
        title: enteredTitle,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    Navigator.pop(context);
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
      _selectedDate = chosenDateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (context, constraints) {
      print("Width: ${constraints.maxWidth}, Height: ${constraints.maxHeight}");
      print("minWidth: ${constraints.minWidth}, minHeight: ${constraints.minHeight}");
      final isLandscape = constraints.maxWidth > 500;
      // final isMobile = constraints.maxWidth < 500;
      // final isTablet = constraints.maxWidth >= 500 && constraints.maxWidth < 1000;
      // final isDesktop = constraints.maxWidth >= 1000;

  
          return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, keyboardHeight + 12),
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
                isLandscape ? Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(label: Text("Title")),
                        keyboardType: TextInputType.text,
                        controller: _titleController,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(label: Text("Amount")),
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                      ),
                    ),
                  ],
                ) : TextField(
                  decoration: const InputDecoration(label: Text("Title")),
                  keyboardType: TextInputType.text,
                  controller: _titleController,
                ),
                
                isLandscape ? Row (
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
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              _selectedDate != null
                                  ? formatter.format(_selectedDate!)
                                  : "Select Date",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: showDatePickerOption,
                            icon: Icon(Icons.calendar_month),
                          ),
                        ],
                      ),
                    ),
                    
                  ],
                ) : Row(
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
                          Flexible(
                            child: Text(
                              _selectedDate != null
                                  ? formatter.format(_selectedDate!)
                                  : "Select Date",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: showDatePickerOption,
                            icon: Icon(Icons.calendar_month),
                          ),
                        ],
                      ),
                    ),
                  ],
                ) ,
                if (isLandscape)
                 Row(
                  children: [
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
                  ]
                 )
                else 
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
        ),
      ),
    );
    });


  }
}
