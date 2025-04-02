import 'package:diamond_report/bloc/diamond_fliter_bloc/diamond_filter_cubit.dart';
import 'package:diamond_report/widgets/appbar_widget.dart';
import 'package:diamond_report/widgets/button_widget.dart';
import 'package:diamond_report/widgets/dropdown_widget.dart';
import 'package:diamond_report/widgets/loader.dart';
import 'package:diamond_report/widgets/show_error.dart';
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
                return Padding(
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
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormFieldWidget(
                              controller: caratToController,
                              label: "Carat To",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      DropdownWidget(
                        label: "Lab",
                        items: dfCubit!.labList!,
                        selectedValue: dfCubit!.selectedLab,
                        onChanged: (val) {
                          dfCubit!.selectedLab = val;
                        },
                      ),
                    ],
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
      child: ButtonWidget(
        title: "Pick Diamond Report",
        onPressed: () async {
          FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['xlsx'],
          );
          dfCubit!.getFilterData(pickedFile);
        },
      ),
    );
  }
}
