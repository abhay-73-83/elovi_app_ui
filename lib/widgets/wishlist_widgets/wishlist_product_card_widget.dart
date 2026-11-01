import 'package:elovi_app_ui/common/common_add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../color/app_colors.dart';
import '../../data/product_catalog.dart';

class WishlistProductCardWidget extends StatefulWidget {
  final Map<String, dynamic> product;
  final Color surfaceColor;
  final Color surface2Color;
  final Color primaryText;
  final Color secondaryText;
  final Color borderColor;
  final VoidCallback onFavoriteTap;
  final VoidCallback onAddToBagTap;

  const WishlistProductCardWidget({
    super.key,
    required this.product,
    required this.surfaceColor,
    required this.surface2Color,
    required this.primaryText,
    required this.secondaryText,
    required this.borderColor,
    required this.onFavoriteTap,
    required this.onAddToBagTap,
  });

  @override
  State<WishlistProductCardWidget> createState() =>
      _WishlistProductCardWidgetState();
}

class _WishlistProductCardWidgetState extends State<WishlistProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenSize = MediaQuery.sizeOf(context);
    final imageWidth = (screenSize.width * 0.32).clamp(100.0, 190.0);
    final imageHeight = (screenSize.height * 0.2).clamp(150.0, 220.0);

    // Brand Colors
    // final brandColor = isDark
    //     ? AppColors.darkBrandAccent
    //     : AppColors.lightBrandSolid;

    // Favorite Icon Colors
    final favoriteColor = isDark
        ? AppColors.darkBrandAccent
        : AppColors.lightBrandSolid;

    // Rating Color
    final ratingColor = isDark
        ? AppColors.darkBrandAccent
        : const Color(0xFF315B2D);

    // Discount Background
    final discountBackground = isDark
        ? AppColors.darkSurface3
        : AppColors.lightBrandAccent;

    // Discount Text
    final discountText = isDark
        ? AppColors.darkBrandAccent
        : AppColors.lightBrandSolid;

    final isFavorite = ProductCatalog.isFavorite(
      widget.product['name'] as String,
    );

    return Container(
      margin: EdgeInsets.only(bottom: 1.5.h),
      padding: EdgeInsets.all(1.3.w),
      decoration: BoxDecoration(
        color: widget.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: widget.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          // Product Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.product['image'],
                  height: imageHeight,
                  width: imageWidth,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: imageHeight,
                      width: imageWidth,
                      color: widget.surface2Color,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: widget.secondaryText,
                      ),
                    );
                  },
                ),
              ),

              // Favorite Button
              Positioned(
                top: 1.h,
                right: 2.w,
                child: GestureDetector(
                  onTap: widget.onFavoriteTap,
                  child: Container(
                    padding: EdgeInsets.all(1.w),
                    decoration: BoxDecoration(
                      // color: widget.surfaceColor.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 20.sp,
                      color: isFavorite ? favoriteColor : widget.secondaryText,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: 1.3.w),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category
                // Container(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 2.w,
                //     vertical: 0.4.h,
                //   ),
                //   decoration: BoxDecoration(
                //     color: widget.surface2Color,
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   child: Text(
                //     widget.product['category'].toString().toUpperCase(),
                //     style: TextStyle(
                //       fontSize: 12.5.sp,
                //       color: widget.primaryText,
                //     ),
                //   ),
                // ),

                // SizedBox(height: 0.5.h),

                // Product Name
                Text(
                  widget.product['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: widget.primaryText,
                  ),
                ),

                // SizedBox(height: 0.4.h),

                // Brand
                Text(
                  widget.product['brand'],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: widget.secondaryText,
                  ),
                ),

                SizedBox(height: 0.4.h),

                // Rating
                Row(
                  children: [
                    Icon(Icons.star, size: 18.sp, color: ratingColor),
                    SizedBox(width: 0.4.w),
                    Text(
                      widget.product['rating'],
                      style: TextStyle(
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.bold,
                        color: widget.secondaryText,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 0.4.h),

                // Price
                Row(
                  children: [
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '\$${(widget.product['price'] as num).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                            color: widget.primaryText,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 2.w),

                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '\$${(widget.product['oldPrice'] as num).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 17.sp,
                            decoration: TextDecoration.lineThrough,
                            color: widget.secondaryText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // SizedBox(height: 0.8.h),

                // Discount + Add To Bag
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: discountBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.product['discount'],
                        style: TextStyle(
                          fontSize: 14.5.sp,
                          color: discountText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Common Add To Cart Button
                    CommonAddToCartButton(onTap: widget.onAddToBagTap),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
