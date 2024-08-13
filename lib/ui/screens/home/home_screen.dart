import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:receipe_app/core/utils/app_icons.dart';

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
              _buildNavItem(AppIcons.homeInactive, 0),
              _buildNavItem(AppIcons.bookmarksInactive, 1),
              SizedBox(width: 40),
              _buildNavItem(AppIcons.notificationInactive, 2),
              _buildNavItem(AppIcons.profileInactive, 3),
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
        // colorFilter: ColorFilter.mode(
        //   _selectedIndex == index ? Colors.orange : Colors.grey,
        //   BlendMode.srcIn,
        // ),
      ),
      onPressed: () => setState(() => _selectedIndex = index),
    );
  }
}
