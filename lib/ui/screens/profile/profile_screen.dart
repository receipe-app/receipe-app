import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.black)),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage("assets/images/default_profile.png"),
                ),
                _buildInfoColumn('Recipe', '4'),
                _buildInfoColumn('Followers', '2.5M'),
                _buildInfoColumn('Following', '259'),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Afuwape Abiodun',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Chef',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Private Chef\nPassionate about food and life 🍲🍳🍱',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: const Text('More...'),
            ),
            const SizedBox(height: 16),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     _buildCategoryButton('Recipe', true),
            //     const SizedBox(width: 8),
            //     _buildCategoryButton('Videos', false),
            //     const SizedBox(width: 8),
            //     _buildCategoryButton('Tag', false),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

Widget _buildInfoColumn(String label, String count) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        count,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
    ],
  );
}

 // Widget _buildCategoryButton(String label, bool isSelected) {
  //   return Expanded(
  //     child: ElevatedButton(
  //       onPressed: () {},
  //       style: ElevatedButton.styleFrom(
  //         foregroundColor: isSelected ? Colors.white : Colors.black,
  //         backgroundColor: isSelected ? Colors.green : Colors.grey[200],
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //       ),
  //       child: Text(label),
  //     ),
  //   );
  // }