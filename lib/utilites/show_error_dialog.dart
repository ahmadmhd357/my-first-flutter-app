import 'package:flutter/material.dart';

Future<void> showErorrDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(' Erorr ', style: TextStyle(color: Colors.red)),
        content: Text(
          text,
          style: const TextStyle(color: Colors.red),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          )
        ],
      );
    },
  );
}
