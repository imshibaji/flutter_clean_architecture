import 'package:flutter/material.dart';

Future<void> deleteConfirmDialog(BuildContext context,
    {required void Function() onAction}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Are you sure?'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('This is data will be deleted Permanently.'),
              Text('Re-Thinking about your action.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              onAction();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
