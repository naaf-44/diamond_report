import 'package:diamond_report/utils/preference_handler.dart';
import 'package:get_it/get_it.dart';

/// dependency injection used to optimize the performance of the application.
final GetIt getIt = GetIt.instance;

void inject() {
  getIt.registerLazySingleton<PreferenceHandler>(PreferenceHandler.new);
}
