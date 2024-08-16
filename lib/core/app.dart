import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

import '../ui/screens/splash/splash_screen.dart';
import 'utils/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      ensureScreenSize: true,
      builder: (context, _) {
        return ToastificationWrapper(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: AppColors.primary100,
                selectionColor: AppColors.primary100.withOpacity(0.1),
                selectionHandleColor: AppColors.primary100,
              ),
            ),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
