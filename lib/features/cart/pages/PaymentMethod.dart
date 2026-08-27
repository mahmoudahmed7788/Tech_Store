import 'package:flutter/material.dart';
import 'package:tech_store/core/constsnts/AppStrings.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  static const Color primaryBlue = Color(0xFF4C5DFF);

  String selectedMethod = 'Cash on Delivery';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;

    final secondaryColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.65) ?? Colors.grey;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,

        foregroundColor: textColor,

        elevation: 0,

        title: Text(
          AppStrings.get(context, en: 'Payment Methods', ar: 'طرق الدفع'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),

          children: [
            Text(
              AppStrings.get(
                context,
                en: 'Choose Payment Method',
                ar: 'اختر طريقة الدفع',
              ),
              style: TextStyle(
                color: textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              AppStrings.get(
                context,
                en: 'Select your preferred payment method.',
                ar: 'اختر طريقة الدفع المفضلة لديك.',
              ),
              style: TextStyle(color: secondaryColor, fontSize: 14),
            ),

            const SizedBox(height: 25),

            _paymentTile(
              context: context,
              icon: Icons.money_outlined,
              title: AppStrings.get(
                context,
                en: 'Cash on Delivery',
                ar: 'الدفع عند الاستلام',
              ),
              subtitle: AppStrings.get(
                context,
                en: 'Pay when your order arrives',
                ar: 'ادفع عند وصول طلبك',
              ),
              value: 'Cash on Delivery',
            ),

            _paymentTile(
              context: context,
              icon: Icons.credit_card_outlined,
              title: AppStrings.get(
                context,
                en: 'Credit / Debit Card',
                ar: 'بطاقة ائتمان / خصم',
              ),
              subtitle: AppStrings.get(
                context,
                en: 'Visa, Mastercard and more',
                ar: 'Visa و Mastercard وغيرها',
              ),
              value: 'Credit / Debit Card',
            ),

            _paymentTile(
              context: context,
              icon: Icons.phone_android_outlined,
              title: AppStrings.get(
                context,
                en: 'Mobile Wallet',
                ar: 'المحفظة الإلكترونية',
              ),
              subtitle: AppStrings.get(
                context,
                en: 'Vodafone Cash and other wallets',
                ar: 'فودافون كاش والمحافظ الأخرى',
              ),
              value: 'Mobile Wallet',
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton.icon(
                onPressed: _showAddPaymentMethod,

                icon: const Icon(Icons.add, color: primaryBlue),

                label: Text(
                  AppStrings.get(
                    context,
                    en: 'Add Payment Method',
                    ar: 'إضافة طريقة دفع',
                  ),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: theme.dividerColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
              ),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Icon(Icons.lock_outline, color: primaryBlue, size: 22),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      AppStrings.get(
                        context,
                        en: 'Your payment information is kept secure. Payment details are only used when you complete an order.',
                        ar: 'بيانات الدفع الخاصة بك محفوظة بأمان، ولا يتم استخدامها إلا عند إتمام الطلب.',
                      ),
                      style: TextStyle(
                        color: secondaryColor,
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

  Widget _paymentTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
  }) {
    final theme = Theme.of(context);

    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;

    final secondaryColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.65) ?? Colors.grey;

    final selected = selectedMethod == value;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? primaryBlue : Colors.transparent,
          width: 1.2,
        ),
      ),

      child: RadioListTile<String>(
        value: value,

        groupValue: selectedMethod,

        activeColor: primaryBlue,

        onChanged: (newValue) {
          if (newValue == null) {
            return;
          }

          setState(() {
            selectedMethod = newValue;
          });

          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppStrings.get(
                  context,
                  en: '$title selected',
                  ar: 'تم اختيار $title',
                ),
              ),
              duration: const Duration(milliseconds: 900),
            ),
          );
        },

        secondary: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: primaryBlue.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: primaryBlue),
        ),

        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),

        subtitle: Text(
          subtitle,
          style: TextStyle(color: secondaryColor, fontSize: 12),
        ),
      ),
    );
  }

  void _showAddPaymentMethod() {
    final theme = Theme.of(context);

    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;

    showModalBottomSheet(
      context: context,

      backgroundColor: theme.scaffoldBackgroundColor,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  AppStrings.get(
                    context,
                    en: 'Add Payment Method',
                    ar: 'إضافة طريقة دفع',
                  ),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                _addOption(
                  context: sheetContext,
                  icon: Icons.credit_card,
                  title: AppStrings.get(
                    context,
                    en: 'Credit / Debit Card',
                    ar: 'بطاقة ائتمان / خصم',
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);

                    _showMessage(
                      AppStrings.get(
                        context,
                        en: 'Card payment will be added later.',
                        ar: 'الدفع بالبطاقة سيتم إضافته لاحقاً.',
                      ),
                    );
                  },
                ),

                _addOption(
                  context: sheetContext,
                  icon: Icons.account_balance_wallet_outlined,
                  title: AppStrings.get(
                    context,
                    en: 'Mobile Wallet',
                    ar: 'المحفظة الإلكترونية',
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);

                    _showMessage(
                      AppStrings.get(
                        context,
                        en: 'Mobile wallet will be added later.',
                        ar: 'المحفظة الإلكترونية سيتم إضافتها لاحقاً.',
                      ),
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

  Widget _addOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),

      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
      ),

      child: ListTile(
        leading: Icon(icon, color: primaryBlue),

        title: Text(title, style: TextStyle(color: textColor)),

        trailing: Icon(
          Icons.arrow_forward_ios,
          color: theme.iconTheme.color?.withOpacity(0.5),
          size: 15,
        ),

        onTap: onTap,
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
