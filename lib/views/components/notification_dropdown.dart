import 'package:flutter/material.dart';

class NotificationDropdown extends StatefulWidget {
  @override
  _NotificationDropdownState createState() => _NotificationDropdownState();
}

class _NotificationDropdownState extends State<NotificationDropdown> {
  bool _isDropdownOpen = false;

  final List<Map<String, String>> notifications = [
    {
      'title': 'New Order',
      'description': 'You have received a new order from John.',
      'icon': 'assets/order_icon.png'
    },
    {
      'title': 'Server Issue',
      'description': 'The server is down for maintenance.',
      'icon': 'assets/server_icon.png'
    },
    {
      'title': 'Update Available',
      'description': 'A new update for the app is available.',
      'icon': 'assets/update_icon.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            setState(() {
              _isDropdownOpen = !_isDropdownOpen;
            });
          },
        ),
        if (_isDropdownOpen)
          Positioned(
            top: 50, // Adjust this value based on your layout
            right: 0,
            child: Material(
              elevation: 10, // Higher elevation to ensure it's on top
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey.shade400)],
                ),
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: notifications.map((notification) => _buildNotificationItem(notification)).toList(),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNotificationItem(Map<String, String> notification) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(notification['icon']!),
      ),
      title: Text(notification['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        notification['description']!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        // Handle notification tap
      },
    );
  }
}
