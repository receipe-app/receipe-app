import 'package:flutter/material.dart';
import 'package:receipe_app/core/utils/app_colors.dart';

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
        title: const Text('Profile', style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.primary100,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz, color: AppColors.white))
        ],
      ),
      body: Column(
        children: [
          _buildProfileHeader(),
          TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: AppColors.primary100,
              borderRadius: BorderRadius.circular(25),
            ),
            labelColor: AppColors.white,
            unselectedLabelColor: AppColors.black,
            tabs: const [
              SizedBox(
                width: 300,
                child: Tab(
                  icon: Icon(Icons.restaurant_menu),
                  text: 'Recipe',
                ),
              ),
              SizedBox(
                width: 300,
                child: Tab(
                  icon: Icon(Icons.video_library),
                  text: 'Videos',
                ),
              ),
              SizedBox(
                width: 300,
                child: Tab(
                  icon: Icon(Icons.tag),
                  text: 'Tag',
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildRecipeGrid(),
                _buildRecipeGrid(),
                _buildRecipeGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage:
                    AssetImage("assets/images/default_profile.png"),
                backgroundColor: AppColors.primary100,
              ),
              _buildInfoColumn('Recipe', '4'),
              _buildInfoColumn('Followers', '2.5M'),
              _buildInfoColumn('Following', '259'),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Afuwape Abiodun',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const Text('Chef',
              style: TextStyle(color: Colors.grey, fontSize: 16)),
          const Text(
            'Private Chef\nPassionate about food and life 🍲🍳🍱',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, String count) {
    return Column(
      children: [
        Text(count,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildRecipeGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return _buildRecipeCard(
          imagePath: "assets/images/recipe${index % 2 + 1}.png",
          title: "Recipe ${index + 1}",
          author: "By Chef John",
          time: "20 min",
          rating: "4.0",
        );
      },
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Image.asset(imagePath,
                    height: 120, width: double.infinity, fit: BoxFit.cover),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(rating,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(author,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(time,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite_border,
                          color: AppColors.primary100, size: 20),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
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
