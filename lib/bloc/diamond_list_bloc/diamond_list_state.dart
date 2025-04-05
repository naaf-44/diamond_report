part of 'diamond_list_cubit.dart';

@freezed
class DiamondListState with _$DiamondListState {
  const factory DiamondListState.initial() = _Initial;
  const factory DiamondListState.loading() = _Loading;
  const factory DiamondListState.success(List<DiamondReportModel> diamondList) = _Success;
  const factory DiamondListState.error(String errorMessage) = _Error;
}
