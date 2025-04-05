import 'package:diamond_report/bloc/summary_bloc/summary_cubit.dart';
import 'package:diamond_report/model/diamond_report_model.dart';
import 'package:diamond_report/widgets/appbar_widget.dart';
import 'package:diamond_report/widgets/list_item_widget.dart';
import 'package:diamond_report/widgets/loader.dart';
import 'package:diamond_report/widgets/show_error.dart';
import 'package:diamond_report/widgets/snackbar_widget.dart';
import 'package:diamond_report/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc/cart_cubit.dart';
import '../utils/num_utils.dart';

class CartScreen extends StatefulWidget {
  final List<DiamondReportModel>? diamondList;
  final List<String>? lotIdList;

  const CartScreen({super.key, this.diamondList, this.lotIdList});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ValueNotifier<int> notifier = ValueNotifier<int>(0);
  CartCubit? cCubit;

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget.appBar("Cart", showBackButton: true),
      backgroundColor: Colors.black,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CartCubit()..getCartList(widget.lotIdList, widget.diamondList),
          ),
          BlocProvider(create: (context) => SummaryCubit()),
        ],
        child: Column(
          children: [
            BlocBuilder<SummaryCubit, SummaryState>(
              builder: (blocContext, state) {
                return state.map(
                  initial: (_) => Container(),
                  loading: (_) => Loader(),
                  success: (data) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                      padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText("Total Carat: ${data.summaryModel.totalCart}"),
                          TitleText("Total Price: ${NumUtils.currencyFormat(data.summaryModel.totalPrice!)}"),
                          TitleText("Average Price: ${NumUtils.currencyFormat(data.summaryModel.avgPrice!)}"),
                          TitleText("Average Discount: ${NumUtils.currencyFormat(data.summaryModel.avgDiscount!)}"),
                        ],
                      ),
                    );
                  },
                  error: (error) => ShowError(text: "Cart is empty"),
                );
              },
            ),

            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (blocContext, state) {
                  cCubit = blocContext.read<CartCubit>();
                  notifier.value = cCubit!.diamondModel!.length;

                  return state.map(
                    initial: (_) => Loader(),
                    loading: (_) => Loader(),
                    success: (data) {
                      if (cCubit!.diamondModel!.isEmpty) {
                        return ShowError(text: "Cart is empty");
                      }
                      blocContext.read<SummaryCubit>().getSummary(cCubit!.diamondModel!);

                      return ValueListenableBuilder(
                        valueListenable: notifier,
                        builder: (context, value, child) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: value,
                              itemBuilder: (context, index) {
                                DiamondReportModel model = cCubit!.diamondModel![index];

                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  margin: EdgeInsets.only(bottom: 20),
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TitleText("Lot Id: ${model.lotID}"),
                                          ),
                                          const SizedBox(width: 5),
                                          IconButton(
                                            onPressed: () async {
                                              await cCubit!.deleteFromCart(model.lotID);
                                              notifier.value = notifier.value - 1;
                                              if (context.mounted) {
                                                blocContext.read<SummaryCubit>().getSummary(cCubit!.diamondModel!);
                                                SnackBarWidget.show(
                                                  context,
                                                  "Item removed from cart",
                                                );
                                              }
                                            },
                                            icon: Icon(
                                              Icons.remove_circle_outline,
                                            ),
                                            color: Colors.red,
                                          ),
                                        ],
                                      ),
                                      ListItemWidget(model: model),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    error: (error) => ShowError(text: "Cart is empty"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
