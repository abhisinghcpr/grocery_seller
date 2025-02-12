import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../category/category_list_screen.dart';
import '../home/home_screen.dart';
import '../products/add_produts.dart';
import '../users/all_user_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    AllCategoryScreen(),
    AddProductScreen(),
    // AllUsersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: const Color(0xFF121212),
           type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
           // showUnselectedLabels: true,
          items: [
            _buildNavItem(Icons.home, "Home", _selectedIndex == 0),
            _buildNavItem(Icons.category, "Category", _selectedIndex == 1),
            _buildNavItem(Icons.inventory, "Product", _selectedIndex == 2),
            // _buildNavItem(Icons.person, "Profile", _selectedIndex == 3),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon, String label, bool isSelected) {
    return BottomNavigationBarItem(
      icon: isSelected
          ? Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
              color: Colors.amberAccent[100],
              borderRadius: BorderRadius.circular(20),
            ),
              child: Icon(icon, color: Colors.white),
            )
          : Icon(icon),
      label: label,
    );
  }
}
