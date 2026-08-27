import 'package:flutter/material.dart';
import 'package:tech_store/core/constsnts/AppStrings.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  static const Color primaryBlue = Color(0xFF4C5DFF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textColor =
        theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;

    final secondaryColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.65) ??
        theme.colorScheme.onSurface.withOpacity(0.65);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      // =====================================================
      // APP BAR
      // =====================================================
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,

        foregroundColor: textColor,

        elevation: 0,

        title: Text(
          AppStrings.get(context, en: 'Help & Support', ar: 'المساعدة والدعم'),
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),

      // =====================================================
      // BODY
      // =====================================================
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),

          children: [
            // =================================================
            // HEADER
            // =================================================
            Text(
              AppStrings.get(
                context,
                en: 'How can we help you?',
                ar: 'كيف يمكننا مساعدتك؟',
              ),
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
                en: 'Choose an option below to get help.',
                ar: 'اختر أحد الخيارات التالية للحصول على المساعدة.',
              ),
              style: TextStyle(color: secondaryColor, fontSize: 14),
            ),

            const SizedBox(height: 30),

            // =================================================
            // FAQ
            // =================================================
            _helpTile(
              context: context,
              icon: Icons.quiz_outlined,
              title: AppStrings.get(
                context,
                en: 'Frequently Asked Questions',
                ar: 'الأسئلة الشائعة',
              ),
              subtitle: AppStrings.get(
                context,
                en: 'Find answers to common questions',
                ar: 'اعثر على إجابات للأسئلة الشائعة',
              ),
              onTap: () {
                _showFaq(context);
              },
            ),

            // =================================================
            // CONTACT SUPPORT
            // =================================================
            _helpTile(
              context: context,
              icon: Icons.support_agent_outlined,
              title: AppStrings.get(
                context,
                en: 'Contact Support',
                ar: 'تواصل مع الدعم',
              ),
              subtitle: AppStrings.get(
                context,
                en: 'Get in touch with our support team',
                ar: 'تواصل مع فريق الدعم',
              ),
              onTap: () {
                _showContactSupport(context);
              },
            ),

            // =================================================
            // REPORT PROBLEM
            // =================================================
            _helpTile(
              context: context,
              icon: Icons.bug_report_outlined,
              title: AppStrings.get(
                context,
                en: 'Report a Problem',
                ar: 'الإبلاغ عن مشكلة',
              ),
              subtitle: AppStrings.get(
                context,
                en: 'Tell us about a problem you found',
                ar: 'أخبرنا عن المشكلة التي واجهتك',
              ),
              onTap: () {
                _showReportProblem(context);
              },
            ),

            // =================================================
            // ABOUT
            // =================================================
            _helpTile(
              context: context,
              icon: Icons.info_outline,
              title: AppStrings.get(
                context,
                en: 'About Tech Store',
                ar: 'عن Tech Store',
              ),
              subtitle: AppStrings.get(
                context,
                en: 'Learn more about Tech Store',
                ar: 'تعرف على المزيد عن Tech Store',
              ),
              onTap: () {
                _showAbout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // HELP TILE
  // =========================================================

  Widget _helpTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    final textColor =
        theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;

    final secondaryColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.65) ??
        theme.colorScheme.onSurface.withOpacity(0.65);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      decoration: BoxDecoration(
        color: theme.cardColor,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: theme.dividerColor),
      ),

      child: Material(
        color: Colors.transparent,

        borderRadius: BorderRadius.circular(16),

        child: InkWell(
          borderRadius: BorderRadius.circular(16),

          onTap: onTap,

          child: Padding(
            padding: const EdgeInsets.all(17),

            child: Row(
              children: [
                // =================================================
                // ICON
                // =================================================
                Container(
                  width: 50,
                  height: 50,

                  decoration: BoxDecoration(
                    color: primaryBlue.withOpacity(0.15),

                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: Icon(icon, color: primaryBlue, size: 26),
                ),

                const SizedBox(width: 15),

                // =================================================
                // TEXT
                // =================================================
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        subtitle,
                        style: TextStyle(color: secondaryColor, fontSize: 12),
                      ),
                    ],
                  ),
                ),

                // =================================================
                // ARROW
                // =================================================
                Icon(Icons.arrow_forward_ios, color: secondaryColor, size: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // FAQ
  // =========================================================

  void _showFaq(BuildContext context) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,

      backgroundColor: theme.cardColor,

      isScrollControlled: true,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      builder: (sheetContext) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                _sheetTitle(
                  context: sheetContext,
                  icon: Icons.quiz_outlined,
                  title: AppStrings.get(
                    sheetContext,
                    en: 'Frequently Asked Questions',
                    ar: 'الأسئلة الشائعة',
                  ),
                ),

                const SizedBox(height: 20),

                _faqQuestion(
                  context: sheetContext,
                  question: AppStrings.get(
                    sheetContext,
                    en: 'How can I create an account?',
                    ar: 'كيف يمكنني إنشاء حساب؟',
                  ),
                  answer: AppStrings.get(
                    sheetContext,
                    en: 'Go to the Register page and enter your name, email and password.',
                    ar: 'اذهب إلى صفحة التسجيل وأدخل اسمك والبريد الإلكتروني وكلمة المرور.',
                  ),
                ),

                _faqQuestion(
                  context: sheetContext,
                  question: AppStrings.get(
                    sheetContext,
                    en: 'How can I change my language?',
                    ar: 'كيف يمكنني تغيير لغة التطبيق؟',
                  ),
                  answer: AppStrings.get(
                    sheetContext,
                    en: 'Go to Settings → Language and select English or Arabic.',
                    ar: 'اذهب إلى الإعدادات ← اللغة واختر الإنجليزية أو العربية.',
                  ),
                ),

                _faqQuestion(
                  context: sheetContext,
                  question: AppStrings.get(
                    sheetContext,
                    en: 'How can I change the app theme?',
                    ar: 'كيف يمكنني تغيير مظهر التطبيق؟',
                  ),
                  answer: AppStrings.get(
                    sheetContext,
                    en: 'Go to Settings → Appearance and choose your preferred theme.',
                    ar: 'اذهب إلى الإعدادات ← المظهر واختر المظهر الذي تفضله.',
                  ),
                ),

                _faqQuestion(
                  context: sheetContext,
                  question: AppStrings.get(
                    sheetContext,
                    en: 'How can I contact support?',
                    ar: 'كيف يمكنني التواصل مع الدعم؟',
                  ),
                  answer: AppStrings.get(
                    sheetContext,
                    en: 'Open Settings → Help & Support → Contact Support.',
                    ar: 'افتح الإعدادات ← المساعدة والدعم ← تواصل مع الدعم.',
                  ),
                ),

                _faqQuestion(
                  context: sheetContext,
                  question: AppStrings.get(
                    sheetContext,
                    en: 'How can I report a problem?',
                    ar: 'كيف يمكنني الإبلاغ عن مشكلة؟',
                  ),
                  answer: AppStrings.get(
                    sheetContext,
                    en: 'Open Report a Problem and describe the problem you are experiencing.',
                    ar: 'افتح الإبلاغ عن مشكلة واكتب المشكلة التي تواجهها.',
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  // CONTACT SUPPORT
  // =========================================================

  void _showContactSupport(BuildContext context) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,

      backgroundColor: theme.cardColor,

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
                _sheetTitle(
                  context: sheetContext,
                  icon: Icons.support_agent_outlined,
                  title: AppStrings.get(
                    sheetContext,
                    en: 'Contact Support',
                    ar: 'تواصل مع الدعم',
                  ),
                ),

                const SizedBox(height: 25),

                _contactOption(
                  context: sheetContext,
                  icon: Icons.email_outlined,
                  title: AppStrings.get(
                    sheetContext,
                    en: 'Email',
                    ar: 'البريد الإلكتروني',
                  ),
                  subtitle: 'support@techstore.com',
                ),

                _contactOption(
                  context: sheetContext,
                  icon: Icons.chat_outlined,
                  title: AppStrings.get(
                    sheetContext,
                    en: 'Live Chat',
                    ar: 'المحادثة المباشرة',
                  ),
                  subtitle: AppStrings.get(
                    sheetContext,
                    en: 'Chat with our support team',
                    ar: 'تحدث مع فريق الدعم',
                  ),
                ),

                _contactOption(
                  context: sheetContext,
                  icon: Icons.phone_outlined,
                  title: AppStrings.get(
                    sheetContext,
                    en: 'Phone',
                    ar: 'الهاتف',
                  ),
                  subtitle: AppStrings.get(
                    sheetContext,
                    en: 'Contact us by phone',
                    ar: 'تواصل معنا عبر الهاتف',
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  // REPORT PROBLEM
  // =========================================================

  void _showReportProblem(BuildContext context) {
    final theme = Theme.of(context);

    final controller = TextEditingController();

    showDialog(
      context: context,

      builder: (dialogContext) {
        final dialogTheme = Theme.of(dialogContext);

        final textColor =
            dialogTheme.textTheme.bodyLarge?.color ??
            dialogTheme.colorScheme.onSurface;

        final secondaryColor =
            dialogTheme.textTheme.bodyMedium?.color ??
            dialogTheme.colorScheme.onSurfaceVariant;

        return AlertDialog(
          backgroundColor: dialogTheme.cardColor,

          title: Text(
            AppStrings.get(
              dialogContext,
              en: 'Report a Problem',
              ar: 'الإبلاغ عن مشكلة',
            ),
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),

          content: TextField(
            controller: controller,

            maxLines: 5,

            style: TextStyle(color: textColor),

            decoration: InputDecoration(
              hintText: AppStrings.get(
                dialogContext,
                en: 'Describe the problem...',
                ar: 'صف المشكلة التي تواجهها...',
              ),

              hintStyle: TextStyle(color: secondaryColor),

              filled: true,

              fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.5),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),

                borderSide: BorderSide.none,
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),

                borderSide: const BorderSide(color: primaryBlue),
              ),
            ),
          ),

          actions: [
            // =================================================
            // CANCEL
            // =================================================
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child: Text(
                AppStrings.cancel(dialogContext),
                style: TextStyle(color: secondaryColor),
              ),
            ),

            // =================================================
            // SUBMIT
            // =================================================
            TextButton(
              onPressed: () {
                final message = controller.text.trim();

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      message.isEmpty
                          ? AppStrings.get(
                              context,
                              en: 'Please describe the problem first.',
                              ar: 'من فضلك اكتب المشكلة أولاً.',
                            )
                          : AppStrings.get(
                              context,
                              en: 'Problem reported successfully.',
                              ar: 'تم الإبلاغ عن المشكلة بنجاح.',
                            ),
                    ),
                    backgroundColor: message.isEmpty
                        ? Colors.red
                        : Colors.green,
                  ),
                );

                controller.dispose();
              },

              child: Text(
                AppStrings.get(dialogContext, en: 'Submit', ar: 'إرسال'),
                style: const TextStyle(
                  color: primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // ABOUT TECH STORE
  // =========================================================

  void _showAbout(BuildContext context) {
    final theme = Theme.of(context);

    final textColor =
        theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;

    final secondaryColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.65) ??
        theme.colorScheme.onSurface.withOpacity(0.65);

    showModalBottomSheet(
      context: context,

      backgroundColor: theme.cardColor,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                // =================================================
                // ICON
                // =================================================
                Container(
                  width: 70,
                  height: 70,

                  decoration: BoxDecoration(
                    color: primaryBlue.withOpacity(0.15),

                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: const Icon(
                    Icons.devices,
                    color: primaryBlue,
                    size: 38,
                  ),
                ),

                const SizedBox(height: 18),

                // =================================================
                // APP NAME
                // =================================================
                Text(
                  AppStrings.appName(sheetContext),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // =================================================
                // DESCRIPTION
                // =================================================
                Text(
                  AppStrings.get(
                    sheetContext,
                    en: 'Your one-stop destination for the latest technology products and accessories.',
                    ar: 'وجهتك المتكاملة لأحدث المنتجات والإكسسوارات التقنية.',
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: secondaryColor,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 15),

                // =================================================
                // VERSION
                // =================================================
                Text(
                  AppStrings.get(
                    sheetContext,
                    en: 'Version 1.0.0',
                    ar: 'الإصدار 1.0.0',
                  ),
                  style: TextStyle(color: secondaryColor, fontSize: 12),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  // SHEET TITLE
  // =========================================================

  Widget _sheetTitle({
    required BuildContext context,
    required IconData icon,
    required String title,
  }) {
    final theme = Theme.of(context);

    final textColor =
        theme.textTheme.titleLarge?.color ?? theme.colorScheme.onSurface;

    return Row(
      children: [
        Icon(icon, color: primaryBlue, size: 28),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // FAQ QUESTION
  // =========================================================

  Widget _faqQuestion({
    required BuildContext context,
    required String question,
    required String answer,
  }) {
    final theme = Theme.of(context);

    final textColor =
        theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;

    final secondaryColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.65) ??
        theme.colorScheme.onSurface.withOpacity(0.65);

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            question,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            answer,
            style: TextStyle(color: secondaryColor, fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // CONTACT OPTION
  // =========================================================

  Widget _contactOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);

    final textColor =
        theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;

    final secondaryColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.65) ??
        theme.colorScheme.onSurface.withOpacity(0.65);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.45),

        borderRadius: BorderRadius.circular(14),

        border: Border.all(color: theme.dividerColor),
      ),

      child: Row(
        children: [
          Icon(icon, color: primaryBlue, size: 24),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  subtitle,
                  style: TextStyle(color: secondaryColor, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
