import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../color/app_colors.dart';

class CommonCategoryWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CommonCategoryWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final brandColor = isDark
        ? AppColors.darkBrandSolid
        : AppColors.lightBrandSolid;

    final accentColor = isDark
        ? AppColors.darkBrandAccent
        : AppColors.lightBrandAccent;

    final surfaceColor = isDark
        ? AppColors.darkSurface
        : AppColors.lightSurface;

    final textColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    final borderColor = isDark
        ? AppColors.darkBorder
        : AppColors.lightBorder;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20.w,
        height: 5.2.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? brandColor : surfaceColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? brandColor : borderColor,
          ),
        ),
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: isSelected
                ? FontWeight.bold
                : FontWeight.w500,
            color: isSelected ? accentColor : textColor,
          ),
        ),
      ),
    );
  }
}
