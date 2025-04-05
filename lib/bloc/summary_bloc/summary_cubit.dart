import 'package:diamond_report/model/summary_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diamond_report/model/diamond_report_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'summary_state.dart';
part 'summary_cubit.freezed.dart';

class SummaryCubit extends Cubit<SummaryState> {
  SummaryCubit() : super(const SummaryState.initial());

  getSummary(List<DiamondReportModel> cartList) {

    try {
      emit(SummaryState.loading());
      double totalPrice = cartList
          .where((report) => report.finalAmount != null)
          .map((report) => double.tryParse(report.finalAmount ?? '0') ?? 0.0)
          .reduce((a, b) => a + b);

      double totalDiscount = cartList
          .where((report) => report.discount != null)
          .map((report) => double.tryParse(report.discount ?? '0') ?? 0.0)
          .reduce((a, b) => a + b);

      SummaryModel summaryModel = SummaryModel(
        totalCart: cartList.length,
        totalPrice: totalPrice,
        avgPrice: totalPrice / cartList.length,
        avgDiscount: totalDiscount/ cartList.length,
      );

      emit(SummaryState.success(summaryModel));
    } catch (e) {
      emit(SummaryState.error(e.toString()));
    }
  }
}
