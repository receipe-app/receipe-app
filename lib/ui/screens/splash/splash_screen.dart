import 'package:flutter/material.dart';
import 'package:receipe_app/core/utils/device_screen.dart';
import 'package:receipe_app/core/utils/user_constants.dart';
import 'package:receipe_app/data/service/shared_preference/user_prefs_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> collectUserData() async {
    // UserConstants.name = UserPrefsService.name;
  }

  void tester (){
    UserPrefsService.email;
  }

  @override
  Widget build(BuildContext context) {
    tester();
    return Scaffold(
      body: Container(
        height: DeviceScreen.h(context),
        width: DeviceScreen.w(context),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.png'),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: DeviceScreen.w(context) / 1.5,
                child: const Text(
                  'Get Cooking',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Simple way to find Tasty Recipe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
