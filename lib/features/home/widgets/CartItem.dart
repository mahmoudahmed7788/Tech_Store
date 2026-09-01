import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tech_store/data/models/PruductModel.dart';
import 'package:tech_store/features/cart/cubits/CartCubit.dart';

class CartItem extends StatelessWidget {
  final ProductModel product;
  final int quantity;

  const CartItem({
    super.key,
    required this.product,
    required this.quantity,
  });

  static const Color primaryBlue = Color(0xFF4C5DFF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textColor =
        theme.textTheme.bodyLarge?.color ?? Colors.white;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(
              product.thumbnail,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) {
                return const Icon(
                  Icons.image_not_supported,
                );
              },
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: primaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context
                            .read<CartCubit>()
                            .decreaseQuantity(product);
                      },
                      icon: const Icon(
                        Icons.remove_circle_outline,
                      ),
                    ),

                    Text(
                      '$quantity',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        context
                            .read<CartCubit>()
                            .increaseQuantity(product);
                      },
                      icon: const Icon(
                        Icons.add_circle_outline,
                      ),
                    ),

                    const Spacer(),

                    IconButton(
                      onPressed: () {
                        context
                            .read<CartCubit>()
                            .removeFromCart(product);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
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