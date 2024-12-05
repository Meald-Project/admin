import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final List<Map<String, String>> _supportRequests = [
    {
      'name': 'John Doe',
      'category': 'Client',
      'message': 'I am having trouble with my order.',
      'email': 'johndoe@example.com'
    },
    {
      'name': 'Jane Smith',
      'category': 'Livreur',
      'message': 'The app crashes when I try to log in.',
      'email': 'janesmith@example.com'
    },
    // Add more sample data as needed
  ];

  void _showSupportDialog(Map<String, String> request) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Support Request from ${request['name']}'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Category: ${request['category']}'),
              const SizedBox(height: 10),
              Text('Message: ${request['message']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _launchEmail(request['email']!, request['message']!);
                Navigator.of(context).pop();
              },
              child: const Text('Reply via Email'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchEmail(String email, String message) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Support Request&body=$message',
    );

    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open email app')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      body: ListView.builder(
        itemCount: _supportRequests.length,
        itemBuilder: (context, index) {
          final request = _supportRequests[index];
          return ListTile(
            title: Text(request['name']!),
            subtitle: Text('Category: ${request['category']}'),
            onTap: () {
              _showSupportDialog(request);
            },
          );
        },
      ),
    );
  }
}
