
import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() =>
      _PaymentMethodsPageState();
}

class _PaymentMethodsPageState
    extends State<PaymentMethodsPage> {
  static const Color primaryBlue =
      Color(0xFF4C5DFF);

  static const Color cardColor =
      Color(0xFF1A1A1A);

  String selectedMethod = 'Cash on Delivery';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,

        title: const Text(
          'Payment Methods',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),

          children: [
            // =================================================
            // HEADER
            // =================================================

            const Text(
              'Choose Payment Method',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Select your preferred payment method.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 25),

            // =================================================
            // CASH ON DELIVERY
            // =================================================

            _paymentTile(
              icon: Icons.money_outlined,
              title: 'Cash on Delivery',
              subtitle: 'Pay when your order arrives',
              value: 'Cash on Delivery',
            ),

            // =================================================
            // VISA
            // =================================================

            _paymentTile(
              icon: Icons.credit_card_outlined,
              title: 'Credit / Debit Card',
              subtitle: 'Visa, Mastercard and more',
              value: 'Credit / Debit Card',
            ),

            // =================================================
            // VODAFONE CASH
            // =================================================

            _paymentTile(
              icon: Icons.phone_android_outlined,
              title: 'Mobile Wallet',
              subtitle: 'Vodafone Cash and other wallets',
              value: 'Mobile Wallet',
            ),

            const SizedBox(height: 25),

            // =================================================
            // ADD PAYMENT METHOD
            // =================================================

            SizedBox(
              width: double.infinity,
              height: 55,

              child: OutlinedButton.icon(
                onPressed: () {
                  _showAddPaymentMethod();
                },

                icon: const Icon(
                  Icons.add,
                  color: primaryBlue,
                ),

                label: const Text(
                  'Add Payment Method',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Color(0xFF333333),
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // =================================================
            // SECURITY
            // =================================================

            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: const Color(0xFF151515),
                borderRadius:
                    BorderRadius.circular(14),
              ),

              child: const Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Icon(
                    Icons.lock_outline,
                    color: primaryBlue,
                    size: 22,
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      'Your payment information is kept secure. '
                      'Payment details are only used when you complete an order.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // PAYMENT TILE
  // =========================================================

  Widget _paymentTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
  }) {
    final bool selected =
        selectedMethod == value;

    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      decoration: BoxDecoration(
        color: cardColor,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: selected
              ? primaryBlue
              : Colors.transparent,
          width: 1.2,
        ),
      ),

      child: RadioListTile<String>(
        value: value,

        groupValue:
            selectedMethod,

        activeColor:
            primaryBlue,

        onChanged: (newValue) {
          if (newValue == null) {
            return;
          }

          setState(() {
            selectedMethod =
                newValue;
          });

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(
            SnackBar(
              content: Text(
                '$newValue selected',
              ),
            ),
          );
        },

        secondary: Container(
          width: 46,
          height: 46,

          decoration: BoxDecoration(
            color:
                primaryBlue.withOpacity(
              0.15,
            ),

            borderRadius:
                BorderRadius.circular(12),
          ),

          child: Icon(
            icon,
            color: primaryBlue,
          ),
        ),

        title: Text(
          title,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight:
                FontWeight.w600,
          ),
        ),

        subtitle: Text(
          subtitle,

          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // ADD PAYMENT METHOD
  // =========================================================

  void _showAddPaymentMethod() {
    showModalBottomSheet(
      context: context,

      backgroundColor: cardColor,

      shape:
          const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.all(24),

            child: Column(
              mainAxisSize:
                  MainAxisSize.min,

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                const Text(
                  'Add Payment Method',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                _addOption(
                  icon:
                      Icons.credit_card,
                  title:
                      'Credit / Debit Card',
                  onTap: () {
                    Navigator.pop(
                      context,
                    );

                    _showMessage(
                      'Card payment will be added later.',
                    );
                  },
                ),

                _addOption(
                  icon:
                      Icons.account_balance_wallet_outlined,
                  title:
                      'Mobile Wallet',
                  onTap: () {
                    Navigator.pop(
                      context,
                    );

                    _showMessage(
                      'Mobile wallet will be added later.',
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  // ADD OPTION
  // =========================================================

  Widget _addOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),

      decoration: BoxDecoration(
        color:
            const Color(0xFF252525),

        borderRadius:
            BorderRadius.circular(14),
      ),

      child: ListTile(
        leading: Icon(
          icon,
          color: primaryBlue,
        ),

        title: Text(
          title,
          style:
              const TextStyle(
            color: Colors.white,
          ),
        ),

        trailing:
            const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 15,
        ),

        onTap: onTap,
      ),
    );
  }

  // =========================================================
  // MESSAGE
  // =========================================================

  void _showMessage(
    String message,
  ) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
