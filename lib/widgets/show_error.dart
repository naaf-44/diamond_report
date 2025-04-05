import 'package:flutter/material.dart';

class ShowError extends StatelessWidget {
  final String text;
  const ShowError({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text, style: TextStyle(color: Colors.red)));
  }
}
