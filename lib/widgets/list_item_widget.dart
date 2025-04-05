import 'package:diamond_report/model/diamond_report_model.dart';
import 'package:diamond_report/utils/num_utils.dart';
import 'package:diamond_report/widgets/body_text.dart';
import 'package:diamond_report/widgets/row_data_widget.dart';
import 'package:diamond_report/widgets/title_text.dart';
import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  final DiamondReportModel? model;
  const ListItemWidget({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        BodyText("Discount: ${NumUtils.currencyFormat(double.tryParse(model!.discount!) ?? 0)}",),
        const SizedBox(height: 5),
        BodyText("Per Carat Rate: ${NumUtils.currencyFormat(double.tryParse(model!.perCaratRate!) ?? 0)}",),
        const SizedBox(height: 5),
        BodyText("Final Amount: ${NumUtils.currencyFormat(double.tryParse(model!.finalAmount!) ?? 0)}"),
        const SizedBox(height: 20),
        RowDataWidget(
          val1: "Size: ${model!.size}",
          val2: "Carat: ${model!.carat}",
          val3: "LAB: ${model!.lab}",
        ),
        const SizedBox(height: 5),
        RowDataWidget(
          val1: "Shape: ${model!.shape}",
          val2: "Color: ${model!.color}",
          val3: "Clarity: ${model!.clarity}",
        ),
        const SizedBox(height: 5),
        RowDataWidget(
          val1: "Cut: ${model!.cut}",
          val2: "Polish: ${model!.polish}",
          val3: "Symmetry: ${model!.symmetry}",
        ),
        const SizedBox(height: 10),
        TitleText("Key to symbol:"),
        for (int i=0; i < model!.keyToSymbol!.split(",").length; i++)
          if(model!.keyToSymbol!.split(",")[i].isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: BodyText("${i+1}. ${model!.keyToSymbol!.split(",")[i]}"),
            ),
        const SizedBox(height: 10),
        TitleText("Lab comments: ${model!.labComment}"),
      ],
    );
  }
}
