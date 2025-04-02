part of 'diamond_filter_cubit.dart';

@freezed
class DiamondFilterState with _$DiamondFilterState {
  const factory DiamondFilterState.initial() = _Initial;
  const factory DiamondFilterState.loading() = _Loading;
  const factory DiamondFilterState.success() = _Success;
  const factory DiamondFilterState.error(String errorMessage) = _Error;
}
