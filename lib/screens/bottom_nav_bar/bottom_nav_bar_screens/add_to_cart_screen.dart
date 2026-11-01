import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../color/app_colors.dart';

class AddToCartScreen extends StatelessWidget {
  const AddToCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      appBar: AppBar(
        title: const Text('Shopping Bag'),
      ),
      body: Center(
        child: Text(
          'Your Shopping Bag is Empty',
          style: TextStyle(
            fontSize: 16.sp,
            color: isDark
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
      ),
    );
  }
}