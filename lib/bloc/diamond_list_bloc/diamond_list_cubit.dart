import 'package:diamond_report/model/diamond_report_model.dart';
import 'package:diamond_report/model/filter_data_model.dart';
import 'package:diamond_report/utils/inject.dart';
import 'package:diamond_report/utils/preference_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'diamond_list_state.dart';
part 'diamond_list_cubit.freezed.dart';

class DiamondListCubit extends Cubit<DiamondListState> {
  DiamondListCubit() : super(const DiamondListState.initial());

  List<DiamondReportModel>? filteredList = [];
  List<String>? lotIdList;
  PreferenceHandler handler = getIt<PreferenceHandler>();

  String? sortBy;
  bool showSort = false;

  getDiamondList(FilterDataModel? filterData, List<DiamondReportModel>? diamondList) {
    try {
      emit(DiamondListState.loading());

      setCart();
      filteredList = diamondList;

      filteredList = filteredList!.where((ele) => (double.tryParse(ele.carat!) ?? 0) >= (double.tryParse(filterData!.caratFrom!) ?? 0) && (double.tryParse(ele.carat!) ?? 0) <= (double.tryParse(filterData.caratTo!) ?? 10000)).toList();

      if (filterData!.lab!.isNotEmpty) {
        filteredList = filteredList!.where((ele) => (ele.lab ?? "") == (filterData.lab ?? "")).toList();
      }

      if (filterData.shape!.isNotEmpty) {
        filteredList = filteredList!.where((ele) => (ele.shape ?? "") == (filterData.shape ?? "")).toList();
      }

      if (filterData.color!.isNotEmpty) {
        filteredList = filteredList!.where((ele) => (ele.color ?? "") == (filterData.color ?? "")).toList();
      }

      if (filterData.clarity!.isNotEmpty) {
        filteredList = filteredList!.where((ele) => (ele.clarity ?? "") == (filterData.clarity ?? "")).toList();
      }
      emit(DiamondListState.success(filteredList!));
    } catch (e) {
      emit(DiamondListState.error(e.toString()));
    }
  }

  setCart() {
    lotIdList = handler.getCart();
  }

  sortList() {
    emit(DiamondListState.loading());

    if(sortBy == null) {
      emit(DiamondListState.success(filteredList!));
    } else {
      List<DiamondReportModel>? tempList = filteredList;

      if (sortBy == "Final Price Ascending") {
        tempList!.sort((a, b) => (double.tryParse(a.finalAmount!) ?? 0).compareTo((double.tryParse(b.finalAmount!) ?? 0)));
      } else if(sortBy == "Final Price Descending") {
        tempList!.sort((a, b) => (double.tryParse(b.finalAmount!) ?? 0).compareTo((double.tryParse(a.finalAmount!) ?? 0)));
      } else if(sortBy == "Carat Price Ascending") {
        tempList!.sort((a, b) => (double.tryParse(a.carat!) ?? 0).compareTo((double.tryParse(b.carat!) ?? 0)));
      } else {
        tempList!.sort((a, b) => (double.tryParse(b.carat!) ?? 0).compareTo((double.tryParse(a.carat!) ?? 0)));
      }

      emit(DiamondListState.success(tempList));
    }
  }

  changeState() {
    emit(DiamondListState.loading());
    emit(DiamondListState.success(filteredList!));
  }

  addToCart(String? lotId) async {
    await handler.addCart(lotId!);
    setCart();
  }

  deleteFromCart(String? lotId) async {
    await handler.deleteCart(lotId!);
    setCart();
  }
}
