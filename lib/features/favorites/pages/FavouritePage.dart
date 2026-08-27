import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_store/features/cart/cubits/CartCubit.dart';
import 'package:tech_store/data/models/PruductModel.dart';


class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  static const Color primaryBlue =
      Color(0xFF4C5DFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: BlocBuilder<CartCubit,
          List<ProductModel>>(
        builder: (context, state) {
          final favorites =
              context.read<CartCubit>().favorites;

          if (favorites.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: primaryBlue,
                    size: 80,
                  ),

                  SizedBox(height: 20),

                  Text(
                    'No Favorites Yet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Add products to your favorites',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(20),

            itemCount: favorites.length,

            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.62,
            ),

            itemBuilder: (context, index) {
              final product =
                  favorites[index];

              return _favoriteCard(
                context,
                product,
              );
            },
          );
        },
      ),
    );
  }

  Widget _favoriteCard(
    BuildContext context,
    ProductModel product,
  ) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/product-details',
          extra: product,
        );
      },

      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius:
              BorderRadius.circular(16),
        ),

        clipBehavior: Clip.antiAlias,

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.white,

                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.contain,
                      cacheWidth: 400,

                      errorBuilder:
                          (context, error, stackTrace) {
                        return const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                          size: 40,
                        );
                      },
                    ),
                  ),

                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<CartCubit>()
                            .removeFromFavorites(
                              product,
                            );
                      },

                      child: Container(
                        padding:
                            const EdgeInsets.all(8),

                        decoration:
                            BoxDecoration(
                          color:
                              Colors.black.withOpacity(
                            0.65,
                          ),
                          shape:
                              BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 21,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 4,
              child: Padding(
                padding:
                    const EdgeInsets.all(12),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,

                      style:
                          const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      '\$${product.price.toStringAsFixed(2)}',

                      style:
                          const TextStyle(
                        color: primaryBlue,
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
