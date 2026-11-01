import 'package:elovi_app_ui/common/common_category_widget.dart';
import 'package:elovi_app_ui/data/product_catalog.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../color/app_colors.dart';
import '../../../widgets/product_list_widget/product_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategory = 0;

  final TextEditingController searchController = TextEditingController();

  final List<String> categories = [
    'Everything',
    'Beauty',
    'Home',
    'Wellness',
    'Tools',
    'Lifestyle',
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;

    final surfaceColor = isDark
        ? AppColors.darkSurface
        : AppColors.lightSurface;

    final primaryText = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    final secondaryText = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    final brandColor = isDark
        ? AppColors.darkBrandSolid
        : AppColors.lightBrandSolid;

    final accentColor = isDark
        ? AppColors.darkBrandAccent
        : AppColors.lightBrandAccent;

    // SEARCH AND CATEGORY FILTER
    final filteredProducts = ProductCatalog.products.where((product) {
      final name = product['name'].toString().toLowerCase();
      final category = product['brand'].toString().toLowerCase();

      final search = searchController.text.toLowerCase();

      final matchesSearch = name.contains(search) || category.contains(search);

      final selected = categories[selectedCategory].toLowerCase();

      final matchesCategory =
          selectedCategory == 0 || category.contains(selected);

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: backgroundColor,

      // APP BAR
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.spa, size: 22.sp, color: brandColor),
            SizedBox(width: 2.w),
            Text(
              'Elovi',
              style: TextStyle(
                fontFamily: 'serif',
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
                color: primaryText,
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SEARCH BAR
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Container(
                  height: 6.5.h,
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, size: 22.sp, color: primaryText),

                      SizedBox(width: 2.w),

                      Expanded(
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          style: TextStyle(fontSize: 18.sp, color: primaryText),
                          decoration: InputDecoration(
                            hintText:
                                'Search over 1000+ plant-based products...',
                            hintStyle: TextStyle(
                              fontSize: 17.sp,
                              color: secondaryText,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: false,
                            isDense: false,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 1.5.h,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // HERO BANNER
              Padding(
                padding: EdgeInsets.fromLTRB(3.5.w, 2.5.h, 3.5.w, 0),
                child: Container(
                  height: 18.h,
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF1B382D), Color(0xFF456D5B)],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -4.w,
                        bottom: -4.h,
                        child: Icon(
                          Icons.eco,
                          size: 48.w,
                          color: Colors.white.withValues(alpha: 0.13),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(3.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pure. Potent. Plant-Based.',
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'serif',
                                fontSize: 20.5.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFE8DFCA),
                              ),
                            ),

                            SizedBox(height: 0.8.h),

                            Text(
                              'Discover our curated essentials for conscious living.',
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.white70,
                              ),
                            ),

                            SizedBox(height: 1.5.h),

                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.8.w,
                                vertical: 0.7.h,
                              ),
                              decoration: BoxDecoration(
                                color: accentColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Explore',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: AppColors.lightTextPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(width: 1.w),

                                  Icon(
                                    Icons.north_east,
                                    size: 16.sp,
                                    color: AppColors.lightTextPrimary,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 1.5.h),

              // CATEGORY HORIZONTAL LIST
              SizedBox(
                height: 5.5.h,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 3.5.w);
                  },
                  itemBuilder: (context, index) {
                    return CommonCategoryWidget(
                      title: categories[index],
                      isSelected: selectedCategory == index,
                      onTap: () {
                        setState(() {
                          selectedCategory = index;
                        });
                      },
                    );
                  },
                ),
              ),

              SizedBox(height: 1.5.h),

              // PRODUCT GRID
              if (filteredProducts.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      final columns = width >= 1000
                          ? 4
                          : width >= 650
                          ? 3
                          : 2;
                      final cardExtent = width >= 650
                          ? 340.0
                          : (34.h).clamp(280.0, 390.0);

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredProducts.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 2.5.w,
                          mainAxisSpacing: 1.5.h,
                          mainAxisExtent: cardExtent,
                        ),
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return ProductCardWidget(
                            name: product['name'],
                            category: product['brand'],
                            price:
                                '\$${(product['price'] as num).toStringAsFixed(2)}',
                            image: product['image'],
                          );
                        },
                      );
                    },
                  ),
                )
              // NO PRODUCTS
              else
                Padding(
                  padding: EdgeInsets.all(5.h),
                  child: Center(
                    child: Text(
                      'No products found',
                      style: TextStyle(color: secondaryText, fontSize: 12.sp),
                    ),
                  ),
                ),

              // BOTTOM SPACE
              // SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
