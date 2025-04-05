import 'package:diamond_report/bloc/diamond_list_bloc/diamond_list_cubit.dart';
import 'package:diamond_report/model/diamond_report_model.dart';
import 'package:diamond_report/model/filter_data_model.dart';
import 'package:diamond_report/screens/cart_screen.dart';
import 'package:diamond_report/utils/app_string.dart';
import 'package:diamond_report/utils/num_utils.dart';
import 'package:diamond_report/widgets/appbar_widget.dart';
import 'package:diamond_report/widgets/button_widget.dart';
import 'package:diamond_report/widgets/list_item_widget.dart';
import 'package:diamond_report/widgets/loader.dart';
import 'package:diamond_report/widgets/row_data_widget.dart';
import 'package:diamond_report/widgets/show_error.dart';
import 'package:diamond_report/widgets/snackbar_widget.dart';
import 'package:diamond_report/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiamondListScreen extends StatefulWidget {
  final FilterDataModel? filterDataModel;
  final List<DiamondReportModel>? diamondList;

  const DiamondListScreen({super.key, this.filterDataModel, this.diamondList});

  @override
  State<DiamondListScreen> createState() => _DiamondListScreenState();
}

class _DiamondListScreenState extends State<DiamondListScreen> {
  DiamondListCubit? dlCubit;
  ValueNotifier<List<String>> notifier = ValueNotifier<List<String>>([]);

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget.appBar(
        "Diamond List", 
        showBackButton: true,
        action: [
          IconButton(
            onPressed: () {
              if(dlCubit != null) {
                dlCubit!.showSort = true;
                dlCubit!.changeState();
              }
            },
            icon: Icon(Icons.sort, color: Colors.white),
          ),
          IconButton(
            onPressed: () async {
              if(dlCubit != null) {
                await Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(
                  diamondList: widget.diamondList,
                  lotIdList: dlCubit!.lotIdList,
                )));
                await dlCubit!.setCart();
                notifier.value = dlCubit!.lotIdList!;
              }
            },
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
          )
        ]
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create:
              (context) =>
                  DiamondListCubit()
                    ..getDiamondList(widget.filterDataModel, widget.diamondList),
          child: BlocBuilder<DiamondListCubit, DiamondListState>(
            builder: (blocContext, state) {
              dlCubit = blocContext.read<DiamondListCubit>();
              notifier.value = dlCubit!.lotIdList!;

              return state.map(
                initial: (_) => Loader(),
                loading: (_) => Loader(),
                success: (data) {
                  if(data.diamondList.isEmpty) {
                    return ShowError(text: "No Data Found");
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(dlCubit!.showSort)
                        Container(
                        margin: EdgeInsets.only(bottom: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sort By",
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(height: 10),
                            for(var data in AppString.sortList)
                              ListTile(
                                title: TitleText(data),
                                leading: Radio(
                                  groupValue: dlCubit!.sortBy,
                                  activeColor: Colors.white,
                                  onChanged: (val) {
                                    dlCubit!.sortBy = val;
                                    dlCubit!.changeState();
                                  },
                                  value: data,
                                ),
                                contentPadding: EdgeInsets.zero,
                              ),
                            Row(
                              children: [
                                Expanded(child: ButtonWidget(onPressed: (){
                                  dlCubit!.showSort = false;
                                  dlCubit!.sortBy = null;
                                  dlCubit!.sortList();
                                }, title: "Clear")),
                                const SizedBox(width: 10),
                                Expanded(child: ButtonWidget(onPressed: () {
                                  dlCubit!.showSort = false;
                                  dlCubit!.sortList();
                                }, title: "Sort")),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: data.diamondList.length,
                          itemBuilder: (context, index) {
                            DiamondReportModel model = data.diamondList[index];
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
                                      ValueListenableBuilder(
                                        valueListenable: notifier,
                                        builder: (context, value, child) {
                                          return Row(
                                            children: [
                                              if(value.contains(model.lotID))
                                                IconButton(onPressed: () async {
                                                  await dlCubit!.deleteFromCart(model.lotID);
                                                  notifier.value = dlCubit!.lotIdList!;
                                                  if(context.mounted) {
                                                    SnackBarWidget.show(context, "Item removed from cart");
                                                  }
                                                }, icon: Icon(Icons.remove_circle_outline), color: Colors.red)
                                              else
                                                IconButton(onPressed: () async {
                                                  await dlCubit!.addToCart(model.lotID);
                                                  notifier.value = dlCubit!.lotIdList!;
                                                  if(context.mounted) {
                                                    SnackBarWidget.show(context, "Item added to cart");
                                                  }
                                                }, icon: Icon(Icons.add_circle_outline), color: Colors.white),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  ListItemWidget(model: model),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
                error: (error) => ShowError(text: error.toString()),
              );
            },
          ),
        ),
      ),
    );
  }
}
