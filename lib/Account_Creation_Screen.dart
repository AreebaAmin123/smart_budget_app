import 'package:flutter/material.dart';
import 'package:smart_budget_app/Amount_Input.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text('Create Account',
          style: TextStyle(
              fontSize: 28,
              color: Colors.white
          ),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 32,top: 283,right: 32,
        ),
        child: Column(
          children: <Widget>[
            Center(
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Name',

                ),
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AmountInputScreen(
                        accountName: _nameController.text,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a name')),
                  );
                }
              },
              child: const Text('Create Account',
                style: TextStyle(
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
