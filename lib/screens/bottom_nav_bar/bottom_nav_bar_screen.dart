
import 'package:elovi_app_ui/screens/bottom_nav_bar/bottom_nav_bar_screens/add_to_cart_screen.dart';
import 'package:elovi_app_ui/screens/bottom_nav_bar/bottom_nav_bar_screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../color/app_colors.dart';
import 'bottom_nav_bar_screens/home_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() =>
      _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const WishlistScreen(),
    const AddToCartScreen(),
  ];

  final List<IconData> unSelectedIcons = [
    Icons.home_outlined,
    Icons.favorite_border_rounded,
    Icons.shopping_bag_outlined,
  ];

  final List<IconData> selectedIcons = [
    Icons.home,
    Icons.favorite_outlined,
    Icons.shopping_bag,
  ];

  final List<String> labels = [
    'Home',
    'Wishlist',
    'Cart',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    final surfaceColor = isDark
        ? AppColors.darkSurface
        : AppColors.lightSurface;

    final primaryText = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    final secondaryText = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    final selectedColor = isDark
        ? AppColors.darkBrandAccent
        : AppColors.lightBrandSolid;

    final borderColor = isDark
        ? AppColors.darkBorder
        : AppColors.lightBorder;

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(
            3.5.w,
            0,
            3.5.w,
            0.7.h,
          ),
          padding: EdgeInsets.symmetric(
            vertical: 1.h,
          ),
          decoration: BoxDecoration(
            color: surfaceColor.withOpacity(0.97),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: borderColor,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: List.generate(3, (index) {
              final isSelected = selectedIndex == index;

              return Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSelected
                        ? selectedIcons[index]
                        : unSelectedIcons[index],
                        size: 21.sp,
                        color: isSelected
                            ? selectedColor
                            : secondaryText,
                      ),

                      Text(
                        labels[index],
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: isSelected
                              ? primaryText
                              : secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}