import 'package:flutter/material.dart';

class LocationDialog extends StatelessWidget {
  const LocationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Location'),
      content: Text('Display location details here'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close'),
        ),
      ],
    );
  }
}

// Function to show the location dialog
void showLocationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const LocationDialog();
    },
  );
}
