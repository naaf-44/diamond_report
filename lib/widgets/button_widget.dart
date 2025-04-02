import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String? title;
  final Function()? onPressed;

  const ButtonWidget({super.key, this.title = "", required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.white, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(title!),
    );
  }
}
