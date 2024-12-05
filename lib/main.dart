import 'package:flutter/material.dart';
import 'views/components/sidebar.dart';
import 'views/components/navbar.dart';
import 'views/pages/dashboard_page.dart';
import 'views/pages/collaborators_page.dart';
import 'views/pages/calendar_page.dart';
import 'views/pages/support_page.dart';
import 'views/pages/notification_page.dart';
import 'views/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;
  bool _isSidebarExpanded = false;
  bool _isSidebarVisible = true;
  bool _isSidebarOverlayVisible = false; // State to control sidebar overlay on small screens

  final List<Widget> _pages = [
    DashboardPage(),
    CollaboratorsPage(),
    CalendarPage(),
    SupportPage(),
    NotificationPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isSidebarOverlayVisible = false; // Close sidebar overlay when an item is tapped
    });
  }

  void _onSidebarToggle(bool isExpanded) {
    setState(() {
      _isSidebarExpanded = isExpanded;
    });
  }

  void _toggleSidebarVisibility() {
    setState(() {
      _isSidebarVisible = !_isSidebarVisible;
    });
  }

  // Toggle sidebar overlay visibility on small screens
  void _toggleSidebarOverlay() {
    setState(() {
      _isSidebarOverlayVisible = !_isSidebarOverlayVisible;
      _isSidebarExpanded = true; // Ensure sidebar is always expanded when visible on small screens
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          // Main content with dismissible gesture for small screen overlay sidebar
          GestureDetector(
            onTap: () {
              // Dismiss the sidebar overlay when tapping outside on small screens
              if (_isSidebarOverlayVisible && isSmallScreen) {
                setState(() {
                  _isSidebarOverlayVisible = false;
                });
              }
            },
            child: Row(
              children: [
                // Sidebar behavior based on screen size
                if (!isSmallScreen && _isSidebarVisible)
                  SizedBox(
                    width: _isSidebarExpanded ? 200 : 70,
                    child: Sidebar(
                      onItemTapped: _onItemTapped,
                      onSidebarToggle: _onSidebarToggle,
                    ),
                  ),
                // Main content area
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      Expanded(
                        child: _pages[_selectedIndex],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Navbar that spans the top
          Positioned(
            top: 0,
            left: !isSmallScreen && _isSidebarVisible ? (_isSidebarExpanded ? 200 : 70) : 0,
            right: 0,
            child: SizedBox(
              height: 60, 
              child: Navbar(
                isSidebarExpanded: _isSidebarExpanded,
                onMenuPressed: isSmallScreen ? _toggleSidebarOverlay : _toggleSidebarVisibility,
                userName: 'Admin User',
              ),
            ),
          ),
          // Overlay Sidebar for small screens
          if (_isSidebarOverlayVisible && isSmallScreen)
            Stack(
              children: [
                // Semi-transparent overlay
                GestureDetector(
                  onTap: () {
                    // Close the sidebar overlay when tapping outside
                    setState(() {
                      _isSidebarOverlayVisible = false;
                    });
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
                  ),
                ),
                // Sidebar positioned on top
                Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  child: Material(
                    elevation: 8,
                    child: SizedBox(
                      width: 200, // Sidebar always in expanded mode on small screens
                      child: Sidebar(
                        onItemTapped: (int index) {
                          _onItemTapped(index);
                          setState(() {
                            _isSidebarOverlayVisible = false; // Close sidebar after selecting an item
                          });
                        },
                        onSidebarToggle: _onSidebarToggle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
