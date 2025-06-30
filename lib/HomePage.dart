import 'package:flutter/material.dart';
import 'package:smart_budget_app/Main_Screen.dart';
import 'dart:async';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    MaterialApp(
      debugShowCheckedModeBanner: false,
    );
    return Scaffold(
      body: Center(
        child: Text(
          'Smart Budget App',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
