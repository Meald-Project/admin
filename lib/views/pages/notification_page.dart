import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            _buildNotificationItem(
              title: "New Message",
              description: "You have received a new message from John.",
              time: "2 mins ago",
            ),
            _buildNotificationItem(
              title: "Order Update",
              description: "Your order #12345 has been shipped.",
              time: "1 hour ago",
            ),
            _buildNotificationItem(
              title: "System Alert",
              description: "Scheduled maintenance will occur tomorrow.",
              time: "1 day ago",
            ),
            _buildNotificationItem(
              title: "Welcome",
              description: "Thank you for joining our platform!",
              time: "2 days ago",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String description,
    required String time,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              time,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        leading: const CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.notifications, color: Colors.white),
        ),
      ),
    );
  }
}
