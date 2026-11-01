import 'package:elovi_app_ui/common/common_category_widget.dart';
import 'package:elovi_app_ui/data/product_catalog.dart';
import 'package:elovi_app_ui/widgets/wishlist_widgets/wishlist_product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../color/app_colors.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  int selectedCategory = 0;

  final List<String> categories = [
    'All',
    'Beauty',
    'Home',
    'Wellness',
    'Tools',
  ];

  @override
  void initState() {
    super.initState();
    ProductCatalog.favoriteNames.addListener(_onFavoritesChanged);
  }

  @override
  void dispose() {
    ProductCatalog.favoriteNames.removeListener(_onFavoritesChanged);
    super.dispose();
  }

  void _onFavoritesChanged() {
    if (mounted) setState(() {});
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

    final surface2Color = isDark
        ? AppColors.darkSurface2
        : AppColors.lightSurface2;

    final primaryText = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    final secondaryText = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    final brandColor = isDark
        ? AppColors.darkBrandAccent
        : AppColors.lightBrandSolid;

    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    // Filter products by selected category
    final filteredProducts = ProductCatalog.products.where((product) {
      if (!ProductCatalog.isFavorite(product['name'] as String)) return false;
      if (selectedCategory == 0) {
        return true;
      }

      return product['category'] == categories[selectedCategory];
    }).toList();

    // Count favorite categories
    // final savedCategories = products
    //     .where((product) => product['isFavorite'] == true)
    //     .map((product) => product['category'])
    //     .toSet()
    //     .length;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.spa, size: 22.sp, color: brandColor),
            SizedBox(width: 2.w),
            Text(
              'Elovi Wishlist',
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Wishlist Title
                Text(
                  'My Wishlist',
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 27.sp,
                    fontWeight: FontWeight.bold,
                    color: primaryText,
                  ),
                ),

                SizedBox(height: 0.5.h),

                Text(
                  'Little things. Big happiness.',
                  style: TextStyle(fontSize: 14.sp, color: primaryText),
                ),

                SizedBox(height: 0.5.h),

                Text(
                  'Save now, enjoy later.',
                  style: TextStyle(fontSize: 11.5.sp, color: secondaryText),
                ),

                SizedBox(height: 2.h),

                // Wishlist Summary Card
                // Container(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 3.w,
                //     vertical: 1.8.h,
                //   ),
                //   decoration: BoxDecoration(
                //     color: surfaceColor,
                //     borderRadius: BorderRadius.circular(22),
                //     border: Border.all(color: borderColor),
                //   ),
                //   child: Row(
                //     children: [
                //       Container(
                //         height: 5.5.h,
                //         width: 5.5.h,
                //         decoration: BoxDecoration(
                //           color: brandColor,
                //           shape: BoxShape.circle,
                //         ),
                //         child: Icon(
                //           Icons.favorite,
                //           color: isDark
                //               ? AppColors.darkBackground
                //               : AppColors.lightBrandAccent,
                //           size: 23.sp,
                //         ),
                //       ),
                //
                //       SizedBox(width: 2.w),
                //
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             '$savedItems',
                //             style: TextStyle(
                //               fontSize: 17.sp,
                //               fontWeight: FontWeight.w600,
                //               color: primaryText,
                //             ),
                //           ),
                //           Text(
                //             'Saved items',
                //             style: TextStyle(
                //               fontSize: 10.5.sp,
                //               color: secondaryText,
                //             ),
                //           ),
                //         ],
                //       ),
                //
                //       const Spacer(),
                //
                //       Container(height: 5.h, width: 0.3.w, color: borderColor),
                //
                //       const Spacer(),
                //
                //       Icon(
                //         Icons.spa,
                //         size: 25.sp,
                //         color: const Color(0xFFD4F47B),
                //       ),
                //
                //       SizedBox(width: 2.w),
                //
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             '$savedCategories',
                //             style: TextStyle(
                //               fontSize: 17.sp,
                //               fontWeight: FontWeight.w600,
                //               color: primaryText,
                //             ),
                //           ),
                //           Text(
                //             'Categories',
                //             style: TextStyle(
                //               fontSize: 10.5.sp,
                //               color: secondaryText,
                //             ),
                //           ),
                //         ],
                //       ),
                //
                //       const Spacer(),
                //
                //       GestureDetector(
                //         onTap: () {
                //           setState(() {
                //             selectedCategory = 0;
                //           });
                //         },
                //         child: Container(
                //           padding: EdgeInsets.symmetric(
                //             horizontal: 3.w,
                //             vertical: 1.5.h,
                //           ),
                //           decoration: BoxDecoration(
                //             color: brandColor,
                //             borderRadius: BorderRadius.circular(30),
                //           ),
                //           child: Row(
                //             children: [
                //               Text(
                //                 'View all',
                //                 style: TextStyle(
                //                   fontSize: 10.sp,
                //                   color: isDark ? Colors.black : Colors.white,
                //                 ),
                //               ),
                //               SizedBox(width: 1.w),
                //               Icon(
                //                 Icons.arrow_forward,
                //                 size: 13.sp,
                //                 color: isDark ? Colors.black : Colors.white,
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // SizedBox(height: 2.5.h),

                // Category Chips
                // WishlistCategoryListWidget(
                //   categories: categories,
                //   selectedCategory: selectedCategory,
                //   onCategoryChanged: (index) {
                //     setState(() {
                //       selectedCategory = index;
                //     });
                //   },
                //   surfaceColor: surfaceColor,
                //   primaryText: primaryText,
                //   borderColor: borderColor,
                // ),
                // Category Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(categories.length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 2.w),
                        child: CommonCategoryWidget(
                          title: categories[index],
                          isSelected: selectedCategory == index,
                          onTap: () {
                            setState(() {
                              selectedCategory = index;
                            });
                          },
                        ),
                      );
                    }),
                  ),
                ),

                SizedBox(height: 2.h),

                // Product List
                if (filteredProducts.isEmpty)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(5.h),
                      child: Text(
                        'No products found',
                        style: TextStyle(fontSize: 14.sp, color: secondaryText),
                      ),
                    ),
                  )
                else
                  ...filteredProducts.map((product) {
                    return WishlistProductCardWidget(
                      product: product,
                      surfaceColor: surfaceColor,
                      surface2Color: surface2Color,
                      primaryText: primaryText,
                      secondaryText: secondaryText,
                      borderColor: borderColor,

                      // Favorite Toggle
                      onFavoriteTap: () {
                        ProductCatalog.toggleFavorite(
                          product['name'] as String,
                        );
                      },

                      // Add to Bag
                      onAddToBagTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Added to bag'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    );
                  }),

                SizedBox(height: 1.h),

                // Bottom Banner
                // Container(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 3.w,
                //     vertical: 1.5.h,
                //   ),
                //   decoration: BoxDecoration(
                //     color: const Color(0xFFDDF5A8),
                //     borderRadius: BorderRadius.circular(25),
                //     border: Border.all(color: const Color(0xFFCDEB8C)),
                //   ),
                //   child: Row(
                //     children: [
                //       Container(
                //         height: 5.h,
                //         width: 5.h,
                //         decoration: const BoxDecoration(
                //           color: Color(0xFFC7E98A),
                //           shape: BoxShape.circle,
                //         ),
                //         child: const Icon(Icons.spa, color: Color(0xFF213B30)),
                //       ),
                //
                //       SizedBox(width: 3.w),
                //
                //       Expanded(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               'Still thinking?',
                //               style: TextStyle(
                //                 fontSize: 12.sp,
                //                 color: const Color(0xFF213B30),
                //                 fontWeight: FontWeight.w500,
                //               ),
                //             ),
                //             SizedBox(height: 0.4.h),
                //             Text(
                //               'You have $savedItems items in your wishlist.',
                //               style: TextStyle(
                //                 fontSize: 9.5.sp,
                //                 color: const Color(0xFF213B30),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //
                //       GestureDetector(
                //         onTap: () {
                //           // Discover screen navigation later
                //         },
                //         child: Container(
                //           padding: EdgeInsets.symmetric(
                //             horizontal: 3.w,
                //             vertical: 1.3.h,
                //           ),
                //           decoration: BoxDecoration(
                //             color: const Color(0xFF9FC65B),
                //             borderRadius: BorderRadius.circular(25),
                //           ),
                //           child: Row(
                //             children: [
                //               Text(
                //                 'Explore more',
                //                 style: TextStyle(
                //                   fontSize: 9.5.sp,
                //                   color: Colors.white,
                //                 ),
                //               ),
                //               SizedBox(width: 1.w),
                //               const Icon(
                //                 Icons.arrow_forward,
                //                 size: 14,
                //                 color: Colors.white,
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
