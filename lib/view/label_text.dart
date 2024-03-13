import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  const LabelText({super.key, required this.data, required this.onChanged});
 final String data;
 final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Label"),
      subtitle: Text(data),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Label'),
            content: TextField(
              onChanged: onChanged,
              decoration: const InputDecoration(
                hintText: 'Enter title',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Add Alarm', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        );
      },
    );
  }
}
