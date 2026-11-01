import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../data/product_catalog.dart';
import '../../color/app_colors.dart';
import '../../common/common_add_to_cart.dart';

class ProductCardWidget extends StatefulWidget {
  final String name;
  final String category;
  final String price;
  final String image;

  const ProductCardWidget({
    super.key,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
  });

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    final primaryText = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;

    final secondaryText = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    final brandColor = isDark
        ? AppColors.darkBrandSolid
        : AppColors.lightBrandSolid;

    return Container(
      padding: EdgeInsets.all(1.5.w),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PRODUCT IMAGE

          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }

                        return Container(
                          color: isDark
                              ? AppColors.darkSurface2
                              : AppColors.lightSurface2,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: isDark
                              ? AppColors.darkSurface2
                              : AppColors.lightSurface2,
                          child: Icon(
                            Icons.spa_outlined,
                            size: 35.sp,
                            color: secondaryText,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // // BESTSELLER
                //
                // if (widget.bestseller)
                //   Positioned(
                //     top: 0.8.h,
                //     left: 1.w,
                //     child: Container(
                //       padding: EdgeInsets.symmetric(
                //         horizontal: 2.w,
                //         vertical: 0.4.h,
                //       ),
                //       decoration: BoxDecoration(
                //         color: const Color(0xFFF5F0DF),
                //         borderRadius: BorderRadius.circular(20),
                //       ),
                //       child: Text(
                //         'BESTSELLER',
                //         style: TextStyle(
                //           fontSize: 7.sp,
                //           color: const Color(0xFF30342C),
                //         ),
                //       ),
                //     ),
                //   ),

                // FAVORITE
                Positioned(
                  top: 0.7.h,
                  right: 1.w,
                  child: GestureDetector(
                    onTap: () => ProductCatalog.toggleFavorite(widget.name),
                    child: ValueListenableBuilder<Set<String>>(
                      valueListenable: ProductCatalog.favoriteNames,
                      builder: (context, favorites, child) {
                        final isFavorite = favorites.contains(widget.name);
                        return Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 20.sp,
                          color: brandColor,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 0.7.h),

          // PRODUCT NAME
          Text(
            widget.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17.sp,
              height: 1.25,
              fontWeight: FontWeight.w500,
              color: primaryText,
            ),
          ),

          SizedBox(height: 0.3.h),

          // PRODUCT CATEGORY
          Text(
            widget.category,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13.5.sp, color: secondaryText),
          ),

          // SizedBox(height: 0.7.h),

          // PRICE AND ADD BUTTON
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.price,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 16.5.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.darkSuccess
                        : const Color(0xFF557567),
                  ),
                ),
              ),
              // const Spacer(),
              // SizedBox(width: 10.w,),
              CommonAddToCartButton(onTap: () {}, title: 'Add'),
            ],
          ),
        ],
      ),
    );
  }
}
