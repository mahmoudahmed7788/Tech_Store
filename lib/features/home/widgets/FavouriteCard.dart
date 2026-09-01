import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tech_store/core/constsnts/AppStrings.dart';
import 'package:tech_store/data/models/PruductModel.dart';
import 'package:tech_store/features/cart/cubits/CartCubit.dart';
import 'package:tech_store/features/favorites/cubits/FavouriteCubit.dart';

class FavoriteCard extends StatelessWidget {
  final ProductModel product;

  const FavoriteCard({super.key, required this.product});

  static const Color primaryBlue = Color(0xFF4C5DFF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =================================================
          // IMAGE + FAVORITE
          // =================================================
          SizedBox(
            height: 125,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  child: Image.network(
                    product.thumbnail,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),

                // FAVORITE BUTTON
                Positioned(
                  top: 7,
                  right: 7,
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: IconButton(
                      constraints: const BoxConstraints(
                        minWidth: 34,
                        minHeight: 34,
                        maxWidth: 34,
                        maxHeight: 34,
                      ),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        context.read<FavoritesCubit>().toggleFavorite(product);
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 19,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // =================================================
          // PRODUCT INFO
          // =================================================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: theme.textTheme.bodyLarge?.color,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const Spacer(),

                  // PRICE
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: primaryBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // ADD TO CART
                  SizedBox(
                    width: double.infinity,
                    height: 34,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<CartCubit>().addToCart(product);

                        ScaffoldMessenger.of(context).hideCurrentSnackBar();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(milliseconds: 900),
                            content: Text(
                              AppStrings.get(
                                context,
                                en: 'Added to Cart',
                                ar: 'تمت الإضافة إلى السلة',
                              ),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.shopping_cart_outlined, size: 15),
                            const SizedBox(width: 5),
                            Text(
                              AppStrings.get(
                                context,
                                en: 'Add to Cart',
                                ar: 'إضافة إلى السلة',
                              ),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
