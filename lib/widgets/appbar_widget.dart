import 'package:flutter/material.dart';

class AppbarWidget {
  static AppBar appBar(String title, {bool showBackButton = false, List<Widget>? action}) {
    return AppBar(
      backgroundColor: Colors.black,
      title: Center(child: Text(title, style: TextStyle(color: Colors.white))),
      automaticallyImplyLeading: showBackButton,
      iconTheme: IconThemeData(color: Colors.white),
      actions: action,
    );
  }
}
