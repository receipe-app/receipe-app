import 'package:flutter/material.dart';
import 'package:receipe_app/data/service/shared_preference/user_prefs_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _functionTester() async {}

  @override
  Widget build(BuildContext context) {
    _functionTester();
    return SafeArea(
      child: Column(
        children: [
          Text('data'),
        ],
      ),
    );
  }
}
