import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_store/features/cart/cubits/CartCubit.dart';
import 'package:tech_store/data/models/PruductModel.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  static const Color primaryBlue = Color(0xFF4C5DFF);

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController addressController =
      TextEditingController();

  final TextEditingController cityController =
      TextEditingController();

  String selectedPayment = 'Cash on Delivery';

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    final cart = cartCubit.state;

    final subtotal = cartCubit.getTotal();
    final shipping = 10.0;
    final total = subtotal + shipping;

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),

        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // =================================================
              // DELIVERY INFORMATION
              // =================================================

              const Text(
                'Delivery Information',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              _textField(
                controller: nameController,
                hint: 'Full Name',
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 12),

              _textField(
                controller: phoneController,
                hint: 'Phone Number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 12),

              _textField(
                controller: cityController,
                hint: 'City',
                icon: Icons.location_city_outlined,
              ),

              const SizedBox(height: 12),

              _textField(
                controller: addressController,
                hint: 'Full Address',
                icon: Icons.location_on_outlined,
                maxLines: 3,
              ),

              const SizedBox(height: 30),

              // =================================================
              // PAYMENT
              // =================================================

              const Text(
                'Payment Method',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              _paymentTile(
                title: 'Cash on Delivery',
                subtitle: 'Pay when your order arrives',
                icon: Icons.money,
                value: 'Cash on Delivery',
              ),

              const SizedBox(height: 10),

              _paymentTile(
                title: 'Credit / Debit Card',
                subtitle: 'Pay securely with your card',
                icon: Icons.credit_card,
                value: 'Card',
              ),

              const SizedBox(height: 30),

              // =================================================
              // ORDER SUMMARY
              // =================================================

              const Text(
                'Order Summary',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  children: [
                    _summaryRow(
                      'Products',
                      '${cart.length}',
                    ),

                    const SizedBox(height: 12),

                    _summaryRow(
                      'Subtotal',
                      '\$${subtotal.toStringAsFixed(2)}',
                    ),

                    const SizedBox(height: 12),

                    _summaryRow(
                      'Shipping',
                      '\$${shipping.toStringAsFixed(2)}',
                    ),

                    const Divider(
                      color: Color(0xFF333333),
                      height: 25,
                    ),

                    _summaryRow(
                      'Total',
                      '\$${total.toStringAsFixed(2)}',
                      isTotal: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // =================================================
              // PLACE ORDER
              // =================================================

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: () {
                    _placeOrder(
                      context,
                      cart,
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  child: const Text(
                    'Place Order',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  // =============================================================
  // TEXT FIELD
  // =============================================================

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,

      keyboardType: keyboardType,

      maxLines: maxLines,

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(
        hintText: hint,

        hintStyle: const TextStyle(
          color: Colors.grey,
        ),

        prefixIcon: Icon(
          icon,
          color: Colors.grey,
        ),

        filled: true,

        fillColor: const Color(0xFF1A1A1A),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: primaryBlue,
          ),
        ),
      ),
    );
  }

  // =============================================================
  // PAYMENT TILE
  // =============================================================

  Widget _paymentTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
  }) {
    final selected = selectedPayment == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = value;
        });
      },

      child: Container(
        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),

          borderRadius: BorderRadius.circular(15),

          border: Border.all(
            color: selected
                ? primaryBlue
                : const Color(0xFF333333),
          ),
        ),

        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,

              decoration: BoxDecoration(
                color: selected
                    ? primaryBlue
                    : const Color(0xFF333333),

                borderRadius: BorderRadius.circular(12),
              ),

              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,

              color: selected
                  ? primaryBlue
                  : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // SUMMARY ROW
  // =============================================================

  Widget _summaryRow(
    String title,
    String value, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,

      children: [
        Text(
          title,

          style: TextStyle(
            color: isTotal
                ? Colors.white
                : Colors.grey,

            fontSize: isTotal ? 18 : 14,

            fontWeight: isTotal
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),

        Text(
          value,

          style: TextStyle(
            color: isTotal
                ? primaryBlue
                : Colors.white,

            fontSize: isTotal ? 19 : 14,

            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // =============================================================
  // PLACE ORDER
  // =============================================================

  void _placeOrder(
    BuildContext context,
    List<ProductModel> cart,
  ) {
    if (nameController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        cityController.text.trim().isEmpty ||
        addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill in all delivery information',
          ),
        ),
      );

      return;
    }

    // ---------------------------------------------------------
    // CLEAR CART
    // ---------------------------------------------------------

    context.read<CartCubit>().clearCart();

    // ---------------------------------------------------------
    // GO TO SUCCESS
    // ---------------------------------------------------------

    context.go('/order-success');
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();

    super.dispose();
  }
}
