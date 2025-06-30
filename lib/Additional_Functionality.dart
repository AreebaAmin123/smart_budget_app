import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_budget_app/Class_Model.dart';
import 'package:smart_budget_app/New_Screen.dart';

class AdditionalFunctionality extends StatefulWidget {
  final String accountName;

  const AdditionalFunctionality({super.key, required this.accountName});

  @override
  _AdditionalFunctionalityState createState() => _AdditionalFunctionalityState();
}

class _AdditionalFunctionalityState extends State<AdditionalFunctionality> {
  final List<Entry> entries = [];
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _getFilePath();
  }

  Future<void> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    setState(() {
      _filePath = directory.path;
    });
  }

  void _addCurrentEntry(Entry entry) {
    setState(() {
      entries.add(entry);
    });
    _saveData(entry);
  }

  Future<void> _saveData(Entry entry) async {
    if (_filePath != null) {
      int fileNumber = 1;
      String fileName;

      while (true) {
        fileName = 'data_file_$fileNumber.txt';
        final file = File('$_filePath/$fileName');
        if (await file.exists()) {
          fileNumber++;
        } else {
          break;
        }
      }

      final file = File('$_filePath/$fileName');
      try {
        await file.writeAsString('${entry.toJson()}\n', mode: FileMode.append);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data saved in $fileName')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving data: $e')),
        );
      }
    }
  }

  void _deleteEntry(int index) {
    setState(() {
      entries.removeAt(index);
    });
  }

  void _updateEntry(Entry entry, int index) {
    setState(() {
      entries[index] = entry;
    });
  }

  void _showEditDialog(Entry entry, int index) {
    final _amountController = TextEditingController(text: entry.amount.toString());
    final _descriptionController = TextEditingController(text: entry.description);
    final _memonController = TextEditingController(text: entry.memon);
    String _selectedType = entry.type; // Existing type
    String _selectedCategory = entry.category; // Existing category

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Edit Entry',
            style: TextStyle(
              fontSize: 31,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _amountController,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextFormField(
                  controller: _memonController,
                  decoration: const InputDecoration(labelText: 'Memo'),
                ),
                DropdownButton<String>(
                  value: _selectedType,
                  items: ['Income', 'Expense'].map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedType = newValue!;
                    });
                  },
                ),
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(text: _selectedCategory),
                  decoration: InputDecoration(labelText: 'Category'),
                  onTap: () {
                    _showCategorySelectionDialog((selectedCategory) {
                      setState(() {
                        _selectedCategory = selectedCategory;
                      });
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updatedEntry = Entry(
                  amount: double.tryParse(_amountController.text) ?? 0.0,
                  type: _selectedType,
                  category: _selectedCategory,
                  date: entry.date,
                  time: entry.time,
                  description: _descriptionController.text,
                  memon: _memonController.text,
                  accountName: entry.accountName, // Use the existing account name
                );
                _updateEntry(updatedEntry, index);
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showCategorySelectionDialog(Function(String) onCategorySelected) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          children: [
            ...['Award', 'Salary', 'Lottery', 'Grants', 'Sale',
              'Rental', 'Car', 'Bills', 'Food', 'Health']
                .map((category) => ListTile(
              title: Text(category),
              onTap: () {
                onCategorySelected(category);
                Navigator.of(context).pop();
              },
            ))
                .toList(),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(
          'Welcome, ${widget.accountName}',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: entries.isNotEmpty
                  ? ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Amount: PKR ${entry.amount.toStringAsFixed(2)}'),
                          Text('Type: ${entry.type}'),
                          Text('Date: ${entry.date}'),
                          Text('Time: ${entry.time}'),
                          Text('Category: ${entry.category}'),
                          Text('Description: ${entry.description}'),
                          Text('Memo: ${entry.memon}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _showEditDialog(entry, index),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteEntry(index),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
                  : Center(child: Text('No entries yet. Add a new entry.')),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewScreen(
                description: '',
                memon: '',
                onSave: _addCurrentEntry,
              ),
            ),
          );
        },
        child: const Icon(
            Icons.add, color: Colors.white),
        backgroundColor: Colors.deepOrangeAccent,
        tooltip: 'Add new entry',
      ),
    );
  }
}








