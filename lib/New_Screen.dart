import 'package:flutter/material.dart';
import 'package:smart_budget_app/Class_Model.dart';

class NewScreen extends StatefulWidget {
  final String description;
  final String memon;
  final Function(Entry) onSave; // Callback to send data back

  const NewScreen({
    super.key,
    required this.description,
    required this.memon,
    required this.onSave, // Accept the callback
  });

  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _memonController = TextEditingController();
  String _selectedType = 'Income';
  String _selectedCategory = 'Select Category';
  DateTime _currentDateTime = DateTime.now();

  Color _incomeButtonColor = Colors.grey;
  Color _expenseButtonColor = Colors.grey;

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _memonController.dispose();
    super.dispose();
  }

  void _saveData() {
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final date = _currentDateTime.toLocal().toString().split(' ')[0];
    final time = _currentDateTime.toLocal().toString().split(' ')[1].split('.')[0];

    final description = _descriptionController.text;
    final memon = _memonController.text;

    if (amount > 0) {
      final entry = Entry(
        accountName: 'User',
        amount: amount,
        type: _selectedType,
        category: _selectedCategory,
        date: date,
        time: time,
        description: description,
        memon: memon,
      );

      widget.onSave(entry);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'Fill this Form',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: _saveData,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: _incomeButtonColor,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedType = 'Income';
                        _incomeButtonColor = Colors.red;
                        _expenseButtonColor = Colors.grey; // Reset the other button
                      });
                    },
                    child: Text('Income'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: _expenseButtonColor,
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedType = 'Expense';
                        _expenseButtonColor = Colors.redAccent;
                        _incomeButtonColor = Colors.grey; // Reset the other button
                      });
                    },
                    child: const Text('Expense'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildTextFormField('Date', initialValue: _currentDateTime.toLocal().toString().split(' ')[0]),
                  const SizedBox(height: 30),
                  _buildTextFormField('Time', initialValue: _currentDateTime.toLocal().toString().split(' ')[1].split('.')[0]),
                  const SizedBox(height: 30),
                  _buildTextFormField('Amount', controller: _amountController),
                  const SizedBox(height: 30),
                  _buildTextFormField('Description', controller: _descriptionController),
                  const SizedBox(height: 30),
                  _buildCategoryField(),
                  const SizedBox(height: 30),
                  _buildTextFormField('Memo', controller: _memonController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(String label, {TextEditingController? controller, String? initialValue}) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.deepOrangeAccent,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryField() {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Category',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.deepOrangeAccent,
            width: 2,
          ),
        ),
      ),
      controller: TextEditingController(text: _selectedCategory),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return ListView(
              children: <Widget>[
                ListTile(
                  title: const Text('Award'),
                  onTap: () {
                    setState(() {
                      _selectedCategory = 'Award';
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('Salary'),
                  onTap: () {
                    setState(() {
                      _selectedCategory = 'Salary';
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('Lottery'),
                  onTap: () {
                    setState(() {
                      _selectedCategory = 'Lottery';
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('Fitness'),
                  onTap: () {
                    setState(() {
                      _selectedCategory = 'Fitness';
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('Sale'),
                  onTap: () {
                    setState(() {
                      _selectedCategory = 'Sale';
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('Transportation'),
                  onTap: () {
                    setState(() {
                      _selectedCategory = 'Transportation';
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('Rental'),
                  onTap: () {
                    setState(() {
                      _selectedCategory = 'Rental';
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('Car'),
                  onTap: () {
                    setState(() {
                      _selectedCategory = 'Car';
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('Bills'),
                  onTap: () {
                    setState(() {
                      _selectedCategory = 'Bills';
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('Food'),
                  onTap: () {
                    setState(() {
                      _selectedCategory = 'Food';
                    });
                    Navigator.of(context).pop();
                  },
                ),
                // Add more categories here...
              ],
            );
          },
        );
      },
    );
  }
}




