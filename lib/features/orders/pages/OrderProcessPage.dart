import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  static const Color primaryBlue = Color(0xFF4C5DFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),

            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [
                // =================================================
                // SUCCESS ICON
                // =================================================

                Container(
                  width: 120,
                  height: 120,

                  decoration: BoxDecoration(
                    color: primaryBlue.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.check_circle,
                    color: primaryBlue,
                    size: 90,
                  ),
                ),

                const SizedBox(height: 30),

                // =================================================
                // TITLE
                // =================================================

                const Text(
                  'Order Placed!',
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // =================================================
                // DESCRIPTION
                // =================================================

                const Text(
                  'Your order has been placed successfully.',
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Thank you for shopping with Tech Store.',
                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 40),

                // =================================================
                // CONTINUE SHOPPING
                // =================================================

                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/home');
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),

                    child: const Text(
                      'Continue Shopping',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // =================================================
                // ORDERS
                // =================================================

                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: OutlinedButton(
                    onPressed: () {
                      context.go('/orders');
                    },

                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFF333333),
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),

                    child: const Text(
                      'View My Orders',

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
        ),
      ),
    );
  }
}
