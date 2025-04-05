import 'package:diamond_report/model/diamond_report_model.dart';
import 'package:diamond_report/widgets/title_text.dart';
import 'package:flutter/material.dart';

class RowDataWidget extends StatelessWidget {
  final String? val1;
  final String? val2;
  final String? val3;
  const RowDataWidget({super.key, this.val1, this.val2, this.val3});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TitleText(val1!, textAlign: TextAlign.start)),
        const SizedBox(width: 5),
        Expanded(child: TitleText(val2!, textAlign: TextAlign.center)),
        const SizedBox(width: 5),
        Expanded(child: TitleText(val3!, textAlign: TextAlign.end)),
      ],
    );
  }
}
