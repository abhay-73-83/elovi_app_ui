import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../color/app_colors.dart';
import 'bottom_nav_bar/bottom_nav_bar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? navigationTimer;

  @override
  void initState() {
    super.initState();

    navigationTimer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavBarScreen()),
      );
    });
  }

  @override
  void dispose() {
    navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDarkMode
        ? AppColors.darkSurface3
        : AppColors.lightSurface3;

    final primaryTextColor = isDarkMode
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          children: [
            const Spacer(),

            Image.asset('assets/elovi_logo.png', width: 40.w),

            SizedBox(height: 1.h),

            Text(
              'elovi',
              style: TextStyle(
                color: primaryTextColor,
                fontSize: 36.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: 3,
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
