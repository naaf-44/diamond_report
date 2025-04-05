import 'package:diamond_report/model/summary_model.dart';
import 'package:diamond_report/model/diamond_report_model.dart';
import 'package:diamond_report/utils/inject.dart';
import 'package:diamond_report/utils/preference_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_state.dart';
part 'cart_cubit.freezed.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState.initial());

  PreferenceHandler handler = getIt<PreferenceHandler>();
  List<String>? lotIdList;
  List<DiamondReportModel>? diamondModel;

  getCartList(List<String>? lotIdList, List<DiamondReportModel>? diamondList) {
    emit(CartState.loading());
    try {
      diamondModel = diamondList!.where((obj) => lotIdList!.contains(obj.lotID)).toList();

      emit(CartState.success());
    } catch (e) {
      emit(CartState.error(e.toString()));
    }
  }

  setCart() {
    lotIdList = handler.getCart();
  }

  deleteFromCart(String? lotId) async {
    diamondModel!.removeWhere((ele) => ele.lotID == lotId);
    await handler.deleteCart(lotId!);
    setCart();
  }
}
