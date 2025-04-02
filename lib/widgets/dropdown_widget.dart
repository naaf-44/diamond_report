import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final List<String> items;
  final String label;
  final String? selectedValue;
  final Function(String?)? onChanged;

  const DropdownWidget({
    super.key,
    required this.items,
    required this.label,
    this.selectedValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        labelText: label,
        border: border(),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.white, width: 1.5),
    );
  }
}
