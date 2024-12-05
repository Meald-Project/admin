import 'package:flutter/material.dart';
import 'notification_dropdown.dart';
import 'profile_dropdown.dart'; 

class Navbar extends StatelessWidget {
  final bool isSidebarExpanded;
  final VoidCallback onMenuPressed;
  final String userName;

  Navbar({
    required this.isSidebarExpanded,
    required this.onMenuPressed,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 4),
            blurRadius: 8.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        children: [
          // Menu icon for smaller screens (phone/tablet)
          if (isSmallScreen)
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: onMenuPressed, // Open the Drawer for small screens
            ),

          // Admin Dashboard text only on larger screens
          if (!isSmallScreen)
            Row(
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          
          // Add search bar, notification dropdown, and profile dropdown
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildSearchBar(),
            ),
          ),
          NotificationDropdown(),
          SizedBox(width: 16),
          ProfileDropdown(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: Icon(Icons.search),
      ),
    );
  }
}
