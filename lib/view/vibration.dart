import 'package:flutter/material.dart';

class Vibration extends StatelessWidget {
  const Vibration({super.key, required this.onChanged, required this.value});
  final ValueChanged onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      title: const Text("Vibration"),
      trailing: Switch(
          activeColor: Colors.blue,
          inactiveThumbColor: null,
          value: value,
          onChanged: onChanged
      ),
    );
  }
}
