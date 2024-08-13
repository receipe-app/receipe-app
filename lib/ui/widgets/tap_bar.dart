import 'package:flutter/material.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tab UI Example'),
          bottom: TabBar(
            indicator: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.teal[200],
            tabs: const [
              Tab(text: 'Recipe'),
              Tab(text: 'Videos'),
              Tab(text: 'Tag'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Recipe Page')),
            Center(child: Text('Videos Page')),
            Center(child: Text('Tag Page')),
          ],
        ),
      ),
    );
  }
}
