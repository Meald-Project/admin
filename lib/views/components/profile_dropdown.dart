import 'package:flutter/material.dart';

class ProfileDropdown extends StatefulWidget {
  @override
  _ProfileDropdownState createState() => _ProfileDropdownState();
}

class _ProfileDropdownState extends State<ProfileDropdown> {
  bool _isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: CircleAvatar(
            backgroundImage: AssetImage('assets/profile_picture.jpg'), // Replace with your profile image
          ),
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
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey.shade400)],
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                      onTap: () {
                        // Handle settings tap
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                      onTap: () {
                        // Handle logout tap
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
