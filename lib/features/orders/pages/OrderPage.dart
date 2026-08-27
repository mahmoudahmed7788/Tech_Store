import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_store/features/cart/cubits/CartCubit.dart';
import 'package:tech_store/data/models/PruductModel.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  static const Color primaryBlue = Color(0xFF4C5DFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: BlocBuilder<CartCubit, List<ProductModel>>(
        builder: (context, cart) {
          if (cart.isEmpty) {
            return const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          final cartCubit = context.read<CartCubit>();
          final total = cartCubit.getTotal();

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    final product = cart[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),

                      padding: const EdgeInsets.all(12),

                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: Row(
                        children: [
                          Container(
                            width: 75,
                            height: 75,

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: Image.network(
                              product.thumbnail,
                              fit: BoxFit.contain,

                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
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

                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',

                                  style: const TextStyle(
                                    color: primaryBlue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  'Quantity: ${cartCubit.getQuantity(product)}',

                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 25),

                decoration: const BoxDecoration(
                  color: Color(0xFF111111),

                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        const Text(
                          'Total',

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          '\$${total.toStringAsFixed(2)}',

                          style: const TextStyle(
                            color: primaryBlue,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      height: 52,

                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,

                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: const Color(0xFF1A1A1A),

                                icon: const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 60,
                                ),

                                title: const Text(
                                  'Order Confirmed',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                content: const Text(
                                  'Your order has been placed successfully.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey),
                                ),

                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);

                                      cartCubit.clearCart();

                                      Navigator.pop(context);
                                    },

                                    child: const Text(
                                      'Done',
                                      style: TextStyle(color: primaryBlue),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),

                        child: const Text(
                          'Place Order',

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
