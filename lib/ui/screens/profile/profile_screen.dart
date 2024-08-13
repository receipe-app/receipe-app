import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipe_app/core/utils/app_colors.dart';
import '../../../logic/bloc/auth/auth_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: AppColors.black)),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.white,
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEvent.logout());
              },
              icon: const Icon(Icons.logout))
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
            TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.primary100,
                borderRadius: BorderRadius.circular(20),
              ),
              tabs: [
                Tab(child: _buildTabLabel('Liked', 0)),
                Tab(child: _buildTabLabel('Saved', 1)),
                Tab(child: _buildTabLabel('Created', 2)),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTabContent('Liked Recipes'),
                  _buildTabContent('Saved Recipes'),
                  _buildTabContent('Created Recipes'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabLabel(String label, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Text(
        label,
        style: TextStyle(
          color: _tabController.index == index ? Colors.white : AppColors.gray1,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String count) {
    return Column(
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
            color: AppColors.gray1,
          ),
        ),
      ],
    );
  }

  Widget _buildTabContent(String label) {
    return ListView(
      children: [
        Text(label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildRecipeCard(
          imagePath: "assets/images/recipe1.png",
          title: "Traditional spare ribs baked",
          author: "By Chef John",
          time: "20 min",
          rating: "4.0",
        ),
        const SizedBox(height: 16),
        _buildRecipeCard(
          imagePath: "assets/images/recipe2.png",
          title: "Spice roasted chicken with flavored rice",
          author: "By Mark Kelvin",
          time: "20 min",
          rating: "4.0",
        ),
      ],
    );
  }

  Widget _buildRecipeCard({
    required String imagePath,
    required String title,
    required String author,
    required String time,
    required String rating,
  }) {
    return Card(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imagePath,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(author, style: const TextStyle(color: AppColors.gray1)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time,
                        size: 16, color: AppColors.gray1),
                    const SizedBox(width: 4),
                    Text(time, style: const TextStyle(color: AppColors.gray1)),
                    const Spacer(),
                    const Icon(Icons.star,
                        size: 16, color: AppColors.secondary100),
                    const SizedBox(width: 4),
                    Text(rating,
                        style: const TextStyle(color: AppColors.gray1)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
