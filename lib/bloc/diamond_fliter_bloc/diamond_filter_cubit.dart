import 'dart:io' show File;

import 'package:diamond_report/model/diamond_report_model.dart';
import 'package:diamond_report/utils/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

part 'diamond_filter_state.dart';
part 'diamond_filter_cubit.freezed.dart';

class DiamondFilterCubit extends Cubit<DiamondFilterState> {
  String? selectedLab;
  String? selectedShape;
  String? selectedColor;
  String? selectedClarity;

  List<String>? labList;
  List<String>? shapeList;
  List<String>? colorList;
  List<String>? clarityList;

  List<DiamondReportModel> diamondList = [];

  DiamondFilterCubit() : super(const DiamondFilterState.initial());

  getExcelFilterData(FilePickerResult? pickedFile) async {
    try {
      emit(DiamondFilterState.loading());

      if (pickedFile != null) {
        File file = File(pickedFile.files.single.path!);
        var bytes = await file.readAsBytes();
        var excel = Excel.decodeBytes(bytes);

        for (var table in excel.tables.keys) {
          var rows = excel.tables[table]?.rows;
          if (rows != null && rows.isNotEmpty) {
            for (int i = 2; i < rows.length; i++) {
              var row = rows[i].map((cell) => cell?.value ?? "").toList();
              diamondList.add(DiamondReportModel.fromList(row));
            }
          }
        }

        if(diamondList.length == 2) {
          diamondList.clear();
        } else if(diamondList.length > 2) {
          diamondList = diamondList.sublist(0, diamondList.length - 2);
        }

        setFilterList();

        emit(DiamondFilterState.success());

      } else {
        emit(DiamondFilterState.error("Couldn't read the file"));
      }

    } catch (e) {
      emit(DiamondFilterState.error(e.toString()));
    }
  }

  getDartFilterData() {
    try {
      emit(DiamondFilterState.loading());

      diamondList = dartDiamondReports;
      setFilterList();
      emit(DiamondFilterState.success());
    } catch (e) {
      emit(DiamondFilterState.error(e.toString()));
    }
  }

  changeState() async {
    emit(DiamondFilterState.loading());
    await Future.delayed(const Duration(seconds: 1), () {
      emit(DiamondFilterState.success());
    },);
  }

  setFilterList() {
    labList = diamondList.map((diamond) => diamond.lab ?? "").toSet().where((lab) => lab.isNotEmpty).toList();
    labList!.sort();

    shapeList = diamondList.map((diamond) => diamond.shape ?? "").toSet().where((shape) => shape.isNotEmpty).toList();
    shapeList!.sort();

    colorList = diamondList.map((diamond) => diamond.color ?? "").toSet().where((color) => color.isNotEmpty).toList();
    colorList!.sort();

    clarityList = diamondList.map((diamond) => diamond.clarity ?? "").toSet().where((clarity) => clarity.isNotEmpty).toList();
    clarityList!.sort();
  }
}
