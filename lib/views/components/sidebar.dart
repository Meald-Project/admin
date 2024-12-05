import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  final Function(int) onItemTapped;
  final Function(bool) onSidebarToggle;

  const Sidebar({super.key, required this.onItemTapped, required this.onSidebarToggle});

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool _isExpanded = false; // Default to not expanded
  int? _selectedIndex; // No item is pre-selected
  bool isSmallScreen = false; // Variable to determine screen size

  int _notificationCount = 0; // Example notification count

  @override
  void initState() {
    super.initState();
    // Set the default selection index for larger screens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isSmallScreen = MediaQuery.of(context).size.width < 600;
        // Pre-select "Dashboard" on larger screens
        if (!isSmallScreen) {
          _selectedIndex = 0; // Pre-select Dashboard
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Update screen size flag whenever the screen is built
    isSmallScreen = MediaQuery.of(context).size.width < 600;

    // Ensure sidebar is expanded on small screens
    if (isSmallScreen) {
      _isExpanded = true; // Always expanded on small screens
    }

    return Container(
      width: _isExpanded ? 200.0 : 70.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(4, 0),
            blurRadius: 8.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          // Show expand/collapse button only on larger screens
          if (!isSmallScreen)
            IconButton(
              icon: Icon(
                _isExpanded ? Icons.arrow_back : Icons.arrow_forward,
                color: Colors.black,
                size: 28,
              ),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                  widget.onSidebarToggle(_isExpanded);
                });
              },
            ),
          const SizedBox(height: 20),
          _buildSidebarItem(index: 0, icon: Icons.dashboard, title: 'Dashboard'),
          const SizedBox(height: 16),
          _buildSidebarItem(index: 1, icon: Icons.people, title: 'Collaborators'),
          const SizedBox(height: 16),
          _buildSidebarItem(index: 2, icon: Icons.calendar_today, title: 'Calendar'),
          const SizedBox(height: 16),
          _buildSidebarItem(index: 3, icon: Icons.support, title: 'Support'),
          const SizedBox(height: 16),
          _buildNotificationItem(index: 4, icon: Icons.notifications, title: 'Notifications'),
          const Spacer(),
          _buildSidebarItem(
            index: -1,
            icon: Icons.logout,
            title: 'Logout',
            color: Colors.red,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required int index,
    required IconData icon,
    required String title,
    Color color = Colors.black,
  }) {
    // Highlight item only if selected and not on small screens
    bool isSelected = _selectedIndex == index && !isSmallScreen;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index; 
          _notificationCount = 0; 
          widget.onItemTapped(index);
// /
        });
      },
      child: Container(
        color: isSelected ? Colors.green.withOpacity(0.2) : Colors.transparent, 
        child: ListTile(
          leading: Stack(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.green : color, 
                size: 28,
              ),
              if (_notificationCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$_notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          title: _isExpanded
              ? Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.green : color, // Green text for selected item
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildSidebarItem({
    required int index,
    required IconData icon,
    required String title,
    Color color = Colors.black,
  }) {
    // Highlight item only if selected and not on small screens
    bool isSelected = _selectedIndex == index && !isSmallScreen;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index; // Update selected index only when tapped
          if (index != -1) {
            widget.onItemTapped(index);
          }
        });
      },
      child: Container(
        color: isSelected ? Colors.green.withOpacity(0.2) : Colors.transparent, // Green highlight for selected item
        child: ListTile(
          leading: Icon(
            icon,
            color: isSelected ? Colors.green : color, 
            size: 28,
          ),
          title: _isExpanded
              ? Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.green : color, // Green text for selected item
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
