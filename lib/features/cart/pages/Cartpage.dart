import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_store/data/models/PruductModel.dart';
import 'package:tech_store/features/cart/cubits/CartCubit.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
if (context.canPop()) {
  context.pop();
} else {
  context.go('/home');
}          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),

        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: BlocBuilder<CartCubit, List<ProductModel>>(
        builder: (context, cart) {
          // =====================================================
          // EMPTY CART
          // =====================================================

          if (cart.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: primaryBlue,
                    size: 90,
                  ),

                  SizedBox(height: 20),

                  Text(
                    'Your Cart is Empty',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    'Add some products to your cart',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }

          final cartCubit = context.read<CartCubit>();

          final total = cartCubit.getTotal();

          return Column(
            children: [
              // =================================================
              // PRODUCTS
              // =================================================

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),

                  itemCount: cart.length,

                  itemBuilder: (context, index) {
                    final product = cart[index];

                    final quantity =
                        cartCubit.getQuantity(product);

                    // منع تكرار نفس المنتج في العرض
                    if (index > 0 &&
                        cart[index - 1].id == product.id) {
                      return const SizedBox.shrink();
                    }

                    return _cartItem(
                      context,
                      product,
                      quantity,
                    );
                  },
                ),
              ),

              // =================================================
              // TOTAL SECTION
              // =================================================

              Container(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  18,
                  20,
                  20,
                ),

                decoration: const BoxDecoration(
                  color: Color(0xFF111111),

                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25),
                  ),
                ),

                child: SafeArea(
                  top: false,

                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                        children: [
                          const Text(
                            'Subtotal',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),

                          Text(
                            '\$${total.toStringAsFixed(2)}',

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                        children: const [
                          Text(
                            'Shipping',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),

                          Text(
                            '\$10.00',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const Divider(
                        color: Color(0xFF333333),
                        height: 25,
                      ),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            '\$${(total + 10).toStringAsFixed(2)}',

                            style: const TextStyle(
                              color: primaryBlue,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // =================================================
                      // CHECKOUT BUTTON
                      // =================================================

                      SizedBox(
                        width: double.infinity,
                        height: 55,

                        child: ElevatedButton(
                          onPressed: () {
                            context.push('/checkout');
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryBlue,

                            elevation: 0,

                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(15),
                            ),
                          ),

                          child: const Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,

                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                color: Colors.white,
                              ),

                              SizedBox(width: 10),

                              Text(
                                'Checkout',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // =============================================================
  // CART ITEM
  // =============================================================

  Widget _cartItem(
    BuildContext context,
    ProductModel product,
    int quantity,
  ) {
    final cartCubit = context.read<CartCubit>();

    return Container(
      margin: const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),

        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        children: [
          // =====================================================
          // IMAGE
          // =====================================================

          Container(
            width: 90,
            height: 90,

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius: BorderRadius.circular(12),
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),

              child: Image.network(
                product.thumbnail,

                fit: BoxFit.contain,

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
          ),

          const SizedBox(width: 12),

          // =====================================================
          // PRODUCT INFO
          // =====================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  product.title,

                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  '\$${product.price.toStringAsFixed(2)}',

                  style: const TextStyle(
                    color: primaryBlue,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // =================================================
                // QUANTITY
                // =================================================

                Row(
                  children: [
                    _quantityButton(
                      icon: Icons.remove,
                      onTap: () {
                        cartCubit.decreaseQuantity(
                          product,
                        );
                      },
                    ),

                    const SizedBox(width: 12),

                    Text(
                      quantity.toString(),

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(width: 12),

                    _quantityButton(
                      icon: Icons.add,
                      onTap: () {
                        cartCubit.increaseQuantity(
                          product,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // =====================================================
          // DELETE
          // =====================================================

          IconButton(
            onPressed: () {
              cartCubit.removeFromCart(
                product,
              );
            },

            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // QUANTITY BUTTON
  // =============================================================

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),

      onTap: onTap,

      child: Container(
        width: 30,
        height: 30,

        decoration: BoxDecoration(
          color: const Color(0xFF333333),

          borderRadius: BorderRadius.circular(8),
        ),

        child: Icon(
          icon,
          color: Colors.white,
          size: 17,
        ),
      ),
    );
  }
}
