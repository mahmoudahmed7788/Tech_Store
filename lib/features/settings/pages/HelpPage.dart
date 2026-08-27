import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  static const Color primaryBlue = Color(0xFF4C5DFF);
  static const Color cardColor = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // =====================================================
      // APP BAR
      // =====================================================
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,

        title: const Text(
          'Help & Support',
          style: TextStyle(fontWeight: FontWeight.bold),
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
            const Text(
              'How can we help you?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Choose an option below to get help.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),

            const SizedBox(height: 30),

            // =================================================
            // FREQUENTLY ASKED QUESTIONS
            // =================================================
            _helpTile(
              context: context,
              icon: Icons.quiz_outlined,
              title: 'Frequently Asked Questions',
              subtitle: 'Find answers to common questions',
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
              title: 'Contact Support',
              subtitle: 'Get in touch with our support team',
              onTap: () {
                _showContactSupport(context);
              },
            ),

            // =================================================
            // REPORT A PROBLEM
            // =================================================
            _helpTile(
              context: context,
              icon: Icons.bug_report_outlined,
              title: 'Report a Problem',
              subtitle: 'Tell us about a problem you found',
              onTap: () {
                _showReportProblem(context);
              },
            ),

            // =================================================
            // ABOUT TECH STORE
            // =================================================
            _helpTile(
              context: context,
              icon: Icons.info_outline,
              title: 'About Tech Store',
              subtitle: 'Learn more about Tech Store',
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
    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
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

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 5),

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

                // =================================================
                // ARROW
                // =================================================
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 15,
                ),
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
    showModalBottomSheet(
      context: context,

      backgroundColor: cardColor,

      isScrollControlled: true,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                _sheetTitle(
                  icon: Icons.quiz_outlined,
                  title: 'Frequently Asked Questions',
                ),

                const SizedBox(height: 20),

                _faqQuestion(
                  'How can I create an account?',
                  'Go to the Register page and enter your name, email and password.',
                ),

                _faqQuestion(
                  'How can I change my language?',
                  'Go to Settings → Language and select English or Arabic.',
                ),

                _faqQuestion(
                  'How can I change the app theme?',
                  'Go to Settings → Dark Mode and choose your preferred theme.',
                ),

                _faqQuestion(
                  'How can I contact support?',
                  'Open Settings → Help & Support → Contact Support.',
                ),

                _faqQuestion(
                  'How can I report a problem?',
                  'Open Report a Problem and describe the problem you are experiencing.',
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
    showModalBottomSheet(
      context: context,

      backgroundColor: cardColor,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                _sheetTitle(
                  icon: Icons.support_agent_outlined,
                  title: 'Contact Support',
                ),

                const SizedBox(height: 25),

                _contactOption(
                  icon: Icons.email_outlined,
                  title: 'Email',
                  subtitle: 'support@techstore.com',
                ),

                _contactOption(
                  icon: Icons.chat_outlined,
                  title: 'Live Chat',
                  subtitle: 'Chat with our support team',
                ),

                _contactOption(
                  icon: Icons.phone_outlined,
                  title: 'Phone',
                  subtitle: 'Contact us by phone',
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
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: cardColor,

          title: const Text(
            'Report a Problem',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),

          content: TextField(
            controller: controller,

            maxLines: 5,

            style: const TextStyle(color: Colors.white),

            decoration: InputDecoration(
              hintText: 'Describe the problem...',

              hintStyle: const TextStyle(color: Colors.grey),

              filled: true,

              fillColor: const Color(0xFF252525),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),

                borderSide: BorderSide.none,
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Problem reported successfully.'),
                  ),
                );
              },

              child: const Text(
                'Submit',

                style: TextStyle(
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
    showModalBottomSheet(
      context: context,

      backgroundColor: cardColor,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
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

                const Text(
                  'Tech Store',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Your one-stop destination for the latest technology products and accessories.',

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'Version 1.0.0',

                  style: TextStyle(color: Colors.grey, fontSize: 12),
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

  Widget _sheetTitle({required IconData icon, required String title}) {
    return Row(
      children: [
        Icon(icon, color: primaryBlue, size: 28),

        const SizedBox(width: 12),

        Expanded(
          child: Text(
            title,

            style: const TextStyle(
              color: Colors.white,
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

  Widget _faqQuestion(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            question,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            answer,

            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // CONTACT OPTION
  // =========================================================

  Widget _contactOption({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: const Color(0xFF252525),
        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        children: [
          Icon(icon, color: primaryBlue, size: 24),

          const SizedBox(width: 14),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                title,

                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                subtitle,

                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
