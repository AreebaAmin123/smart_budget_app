//import 'package:untitled1/class_model.dart';
import 'package:flutter/material.dart';
class Entry {
  final double amount;
  final String type;
  final String category;
  final String date;
  final String time;
  final String description;
  final String memon;
  final String accountName;

  Entry({
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    required this.time,
    required this.description,
    required this.memon,
    required this.accountName,
  });

  // Convert the Entry to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'type': type,
      'category': category,
      'date': date,
      'time': time,
      'description': description,
      'memon': memon,
      'accountName': accountName,
    };
  }

  // Create an Entry from a JSON object
  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      amount: json['amount'],
      type: json['type'],
      category: json['category'],
      date: json['date'],
      time: json['time'],
      description: json['description'],
      memon: json['memon'],
      accountName: json['accountName'],
    );
  }
}
