import 'package:flutter/material.dart';

class ContactDialog extends StatelessWidget {
  const ContactDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Contact User'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Call'),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Alerts'),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close'),
        ),
      ],
    );
  }
}

// Function to show the contact dialog
void showContactDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const ContactDialog();
    },
  );
}
