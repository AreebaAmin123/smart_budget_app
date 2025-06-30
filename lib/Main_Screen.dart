import 'package:flutter/material.dart';
import 'package:smart_budget_app/Account_Creation_Screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/WhatsApp Image 2024-09-16 at 9.10.00 PM.jpeg'),
          const SizedBox(height: 20),
          SizedBox(
            width: 200, // Button width
            height: 60, // Button height
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
              //  primary: Colors.lightBlue, // Light blue color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Continue',
              style: TextStyle(
                fontSize: 27,
                color: Colors.red
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
