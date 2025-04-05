import 'package:diamond_report/bloc/diamond_fliter_bloc/diamond_filter_cubit.dart';
import 'package:diamond_report/model/filter_data_model.dart';
import 'package:diamond_report/screens/diamond_list_screen.dart';
import 'package:diamond_report/utils/validation.dart';
import 'package:diamond_report/widgets/appbar_widget.dart';
import 'package:diamond_report/widgets/button_widget.dart';
import 'package:diamond_report/widgets/dropdown_widget.dart';
import 'package:diamond_report/widgets/loader.dart';
import 'package:diamond_report/widgets/show_error.dart';
import 'package:diamond_report/widgets/snackbar_widget.dart';
import 'package:diamond_report/widgets/text_form_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  TextEditingController caratFromController = TextEditingController();
  TextEditingController caratToController = TextEditingController();
  DiamondFilterCubit? dfCubit;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    caratFromController.dispose();
    caratToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget.appBar("Filter"),
      backgroundColor: Colors.black,
      body: BlocProvider(
        create: (context) => DiamondFilterCubit(),
        child: BlocBuilder<DiamondFilterCubit, DiamondFilterState>(
          builder: (blocContext, state) {
            dfCubit = blocContext.read<DiamondFilterCubit>();
            return state.map(
              initial: (_) => pickFileButton(blocContext),
              loading: (_) => Loader(),
              success: (_) {
                return Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormFieldWidget(
                                controller: caratFromController,
                                label: "Carat From",
                                validator: Validation.validateNumber,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormFieldWidget(
                                controller: caratToController,
                                label: "Carat To",
                                validator: Validation.validateNumber,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        DropdownWidget(
                          label: "Lab",
                          items: dfCubit!.labList!,
                          selectedValue: dfCubit!.selectedLab,
                          onChanged: (val) {
                            dfCubit!.selectedLab = val;
                          },
                        ),
                        const SizedBox(height: 20),
                        DropdownWidget(
                          label: "Shape",
                          items: dfCubit!.shapeList!,
                          selectedValue: dfCubit!.selectedShape,
                          onChanged: (val) {
                            dfCubit!.selectedShape = val;
                          },
                        ),
                        const SizedBox(height: 20),
                        DropdownWidget(
                          label: "Color",
                          items: dfCubit!.colorList!,
                          selectedValue: dfCubit!.selectedColor,
                          onChanged: (val) {
                            dfCubit!.selectedColor = val;
                          },
                        ),
                        const SizedBox(height: 20),
                        DropdownWidget(
                          label: "Clarity",
                          items: dfCubit!.clarityList!,
                          selectedValue: dfCubit!.selectedClarity,
                          onChanged: (val) {
                            dfCubit!.selectedClarity = val;
                          },
                        ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Expanded(
                              child: ButtonWidget(
                                onPressed: () {
                                  caratFromController.clear();
                                  caratToController.clear();
                                  dfCubit!.selectedColor = null;
                                  dfCubit!.selectedClarity = null;
                                  dfCubit!.selectedLab = null;
                                  dfCubit!.selectedShape = null;
                                  dfCubit!.changeState();
                                },
                                title: "Clear",
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ButtonWidget(
                                onPressed: () {
                                  if(!formKey.currentState!.validate()) {
                                    return;
                                  }
                                  FilterDataModel model = FilterDataModel(
                                    caratFrom: caratFromController.text,
                                    caratTo: caratToController.text,
                                    color: dfCubit!.selectedColor ?? "",
                                    clarity: dfCubit!.selectedClarity ?? "",
                                    lab: dfCubit!.selectedLab ?? "",
                                    shape: dfCubit!.selectedShape ?? "",
                                  );

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DiamondListScreen(
                                    filterDataModel: model,
                                    diamondList: dfCubit!.diamondList,
                                  )));
                                },
                                title: "Search",
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              error: (error) => ShowError(text: error.errorMessage),
            );
          },
        ),
      ),
    );
  }

  Widget pickFileButton(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: ButtonWidget(
              title: "Pick Excel File",
              onPressed: () async {
                FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['xlsx'],
                );
                if(pickedFile == null && context.mounted) {
                  SnackBarWidget.show(context, "Could not pick the file");
                } else {
                  dfCubit!.getExcelFilterData(pickedFile);
                }
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ButtonWidget(
              title: "Read from data.dart",
              onPressed: () async {
                dfCubit!.getDartFilterData();
              },
            ),
          ),
        ],
      ),
    );
  }
}
