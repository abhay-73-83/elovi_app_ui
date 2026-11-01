import 'package:elovi_app_ui/color/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommonAddToCartButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  const CommonAddToCartButton({
    super.key,
    required this.onTap,
    this.title = 'Add to Cart',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final brandAccentColor = isDark
        ? AppColors.darkBrandAccent
        : AppColors.lightBrandAccent;

    final brandSolidColor = isDark
        ? AppColors.darkBrandSolid
        : AppColors.lightBrandSolid;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: brandAccentColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 16.sp,
              color: brandSolidColor,
            ),
            SizedBox(width: 1.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                color: brandSolidColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
