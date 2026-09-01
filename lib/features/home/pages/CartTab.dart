import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tech_store/core/constsnts/AppStrings.dart';
import 'package:tech_store/data/models/PruductModel.dart';
import 'package:tech_store/features/cart/cubits/CartCubit.dart';
import 'package:tech_store/features/home/widgets/CartItem.dart';
import 'package:tech_store/features/home/widgets/CartBottomBar.dart';

class CartTab extends StatelessWidget {
  const CartTab({super.key});

  static const Color primaryBlue = Color(0xFF4C5DFF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;

    final secondaryColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.65) ?? Colors.grey;

    final cart = context.watch<CartCubit>().state;

    // =================================================
    // EMPTY CART
    // =================================================

    if (cart.isEmpty) {
      return SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_cart_outlined,
                color: primaryBlue,
                size: 80,
              ),

              const SizedBox(height: 20),

              Text(
                AppStrings.get(context, en: 'Your Cart', ar: 'سلتك'),
                style: TextStyle(
                  color: textColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                AppStrings.get(
                  context,
                  en: 'Your cart is empty',
                  ar: 'سلتك فارغة',
                ),
                style: TextStyle(color: secondaryColor, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    final cartCubit = context.read<CartCubit>();
    final total = cartCubit.getTotal();

    // =================================================
    // CART
    // =================================================

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final ProductModel product = cart[index];

                final quantity = cartCubit.getQuantity(product);

                return CartItem(product: product, quantity: quantity);
              },
            ),
          ),

          CartBottomBar(total: total),
        ],
      ),
    );
  }
}
