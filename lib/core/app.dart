import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
      builder: (context, _) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Placeholder(),
        );
      }
    );
  }
}
