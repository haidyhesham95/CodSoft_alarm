
import 'package:flutter/material.dart';

AppBar appBarAlarm(void Function() onTap) {
  return AppBar(
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: onTap,
          child: Icon(Icons.check),
        ),
      )
    ],
    automaticallyImplyLeading: true,
    title: const Text(
      'Add alarm',
      style: TextStyle(
        fontSize: 25,
      ),
    ),
    centerTitle: true,
  );
}
