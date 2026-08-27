import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tech_store/features/cart/cubits/CartCubit.dart';
import 'package:tech_store/data/models/PruductModel.dart';
import 'package:tech_store/features/favorites/cubits/FavouriteCubit.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  static const Color primaryBlue = Color(0xFF4C5DFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),

        title: const Text(
          'Product Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        actions: [
          BlocBuilder<FavoritesCubit, List<ProductModel>>(
            builder: (context, favorites) {
              final isFavorite = context
                  .read<FavoritesCubit>()
                  .isFavorite(product);

              return IconButton(
                onPressed: () {
                  context
                      .read<FavoritesCubit>()
                      .toggleFavorite(product);
                },
                icon: Icon(
                  isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: isFavorite
                      ? Colors.red
                      : Colors.white,
                ),
              );
            },
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            bottom: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =====================================================
              // PRODUCT IMAGE
              // =====================================================

              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                height: 330,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.network(
                    product.thumbnail,
                    fit: BoxFit.contain,
                    cacheWidth: 700,
                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                          size: 70,
                        ),
                      );
                    },
                    loadingBuilder: (
                      context,
                      child,
                      loadingProgress,
                    ) {
                      if (loadingProgress == null) {
                        return child;
                      }

                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryBlue,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // =====================================================
              // PRODUCT INFORMATION
              // =====================================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Rating
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 21,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          product.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(width: 8),

                        const Text(
                          'Rating',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Price
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: primaryBlue,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // =================================================
                    // DESCRIPTION
                    // =================================================

                    const Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      product.description,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // =================================================
                    // BRAND / CATEGORY
                    // =================================================

                    Row(
                      children: [
                        Expanded(
                          child: _infoBox(
                            icon: Icons.category_outlined,
                            title: 'Category',
                            value: product.category,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: _infoBox(
                            icon: Icons.inventory_2_outlined,
                            title: 'Stock',
                            value: product.stock.toString(),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // =================================================
                    // FAVORITE BUTTON
                    // =================================================

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          context
                              .read<FavoritesCubit>()
                              .toggleFavorite(product);
                        },
                        icon: BlocBuilder<
                            FavoritesCubit,
                            List<ProductModel>>(
                          builder: (
                            context,
                            favorites,
                          ) {
                            final isFavorite = context
                                .read<FavoritesCubit>()
                                .isFavorite(product);

                            return Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite
                                  ? Colors.red
                                  : Colors.white,
                            );
                          },
                        ),
                        label: BlocBuilder<
                            FavoritesCubit,
                            List<ProductModel>>(
                          builder: (
                            context,
                            favorites,
                          ) {
                            final isFavorite = context
                                .read<FavoritesCubit>()
                                .isFavorite(product);

                            return Text(
                              isFavorite
                                  ? 'Remove from Favorites'
                                  : 'Add to Favorites',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            );
                          },
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFF444444),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // =================================================
                    // ADD TO CART
                    // =================================================

                    BlocBuilder<CartCubit, List<ProductModel>>(
                      builder: (context, cart) {
                        final isInCart = context
                            .read<CartCubit>()
                            .isInCart(product);

                        return SizedBox(
                          width: double.infinity,
                          height: 58,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (!isInCart) {
                                context
                                    .read<CartCubit>()
                                    .addToCart(product);

                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Product added to cart',
                                    ),
                                    duration:
                                        Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            icon: Icon(
                              isInCart
                                  ? Icons.check
                                  : Icons
                                      .shopping_cart_outlined,
                              size: 22,
                            ),
                            label: Text(
                              isInCart
                                  ? 'Added to Cart'
                                  : 'Add to Cart',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBlue,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===============================================================
  // INFO BOX
  // ===============================================================

  Widget _infoBox({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryBlue,
            size: 24,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
