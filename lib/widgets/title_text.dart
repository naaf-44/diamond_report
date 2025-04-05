import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  const TitleText(this.text, {super.key, this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(text!, textAlign: textAlign, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600));
  }
}
