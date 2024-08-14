import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:receipe_app/core/utils/app_colors.dart';
import 'package:receipe_app/core/utils/app_icons.dart';
import 'package:receipe_app/data/service/shared_preference/user_prefs_service.dart';
import 'package:receipe_app/logic/cubit/tab_box/tab_box_cubit.dart';
import 'package:receipe_app/ui/screens/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _widgets = const [
    Placeholder(),
    FlutterLogo(size: 200),
    Placeholder(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void getUserData() async {
    final String? userEmail = await UserPrefsService.email;
    print(userEmail);
  }

  @override
  Widget build(BuildContext context) {
    getUserData();
    return BlocBuilder<TabBoxCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: _widgets[state],
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            shape: const CircleBorder(),
            backgroundColor: AppColors.primary100,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: BottomAppBar(
              color: Colors.white,
              shape: const CircularNotchedRectangle(),
              notchMargin: 8,
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(AppIcons.homeInactive, 0, state),
                    _buildNavItem(AppIcons.bookmarksInactive, 1, state),
                    const SizedBox(width: 40),
                    _buildNavItem(AppIcons.notificationInactive, 2, state),
                    _buildNavItem(AppIcons.profileInactive, 3, state),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(String assetName, int index, int selectedIndex) {
    return IconButton(
      icon: SvgPicture.asset(
        assetName,
        colorFilter: ColorFilter.mode(
          selectedIndex == index
              ? AppColors.primary100
              : const Color(0xFF797979),
          BlendMode.srcIn,
        ),
      ),
      onPressed: () => context.read<TabBoxCubit>().changeIndex(index),
    );
  }
}
