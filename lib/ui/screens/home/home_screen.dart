import 'package:flutter/material.dart';

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
    return const SafeArea(
      child: Column(
        children: [
          Text('data'),
        ],
      ),
    );
  }
}
