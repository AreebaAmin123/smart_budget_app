import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_budget_app/Additional_Functionality.dart';

class AmountInputScreen extends StatefulWidget {
  final String accountName;

  const AmountInputScreen({super.key, required this.accountName});

  @override
  _AmountInputScreenState createState() => _AmountInputScreenState();
}

class _AmountInputScreenState extends State<AmountInputScreen> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _memonController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _memonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text('Enter Amount',
          style: TextStyle(
              fontSize: 28,
              color: Colors.white
          ),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 22,top: 310,right: 22,
        ),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Enter Amount in PKR',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                // Restrict to decimal numbers
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final amountText = _amountController.text;
                if (amountText.isNotEmpty ) {
                  final amount = double.tryParse(amountText);
                  if (amount != null && amount > 0) { // Ensure amount is positive
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdditionalFunctionality(
                          accountName: widget.accountName,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid amount. Must be greater than zero.')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              child: const Text('Continue',style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 16
              ),),
            ),
          ],
        ),
      ),
    );
  }
}



