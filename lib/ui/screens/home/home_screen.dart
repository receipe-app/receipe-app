import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Content for index $_selectedIndex'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem('assets/icon1.svg', 0),
              _buildNavItem('assets/icon2.svg', 1),
              SizedBox(width: 40), // Space for FAB
              _buildNavItem('assets/icon3.svg', 2),
              _buildNavItem('assets/icon4.svg', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String assetName, int index) {
    return IconButton(
      icon: SvgPicture.asset(
        assetName,
        color: _selectedIndex == index ? Colors.orange : Colors.grey,
      ),
      onPressed: () => setState(() => _selectedIndex = index),
    );
  }
}
