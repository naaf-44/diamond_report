import 'package:diamond_report/screens/filter_screen.dart';
import 'package:diamond_report/utils/inject.dart';
import 'package:diamond_report/utils/preference_handler.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  inject();
  await getIt<PreferenceHandler>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const FilterScreen(),
    );
  }
}
