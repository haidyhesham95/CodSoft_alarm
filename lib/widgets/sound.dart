import 'package:flutter/material.dart';

import '../generated/assets.dart';

class Sound extends StatelessWidget {
 const  Sound({super.key, required this.value,required this.onChanged});
   final String value;
   final ValueChanged onChanged;
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      title: const Text("Alarm Sound"),
      trailing: DropdownButton(
        value: value,
        items: const [
          DropdownMenuItem<String>(
            value: Assets.bell,
            child: Text('Bell'),
          ),
          DropdownMenuItem<String>(
            value: Assets.arabian,
            child: Text('Arabian'),
          ),
          DropdownMenuItem<String>(
            value: Assets.tone,
            child: Text('Tone'),
          ),
          DropdownMenuItem<String>(
            value: Assets.star,
            child: Text('Star'),
          ),
          DropdownMenuItem<String>(
            value: Assets.clear,
            child: Text('Clear'),
          ),
        ],
        onChanged:   onChanged
      ),
    );

  }
}

