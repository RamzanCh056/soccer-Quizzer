import 'package:flutter/material.dart';

class TermAndConditions extends StatefulWidget {
  const TermAndConditions({super.key});

  @override
  State<TermAndConditions> createState() => _TermAndConditionsState();
}

class _TermAndConditionsState extends State<TermAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Terms & Condition',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Text(
              'All quiz questions, and content within the Soccer Quiz App are protected by intellectual property laws. You may not reproduce, distribute, modify, or create derivative works in the App.',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
