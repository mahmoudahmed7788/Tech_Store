import 'package:flutter/material.dart';
import 'package:tech_store/features/settings/Widgets/Help/HelpTitle.dart';


class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  static const primaryBlue = Color(0xFF4C5DFF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor:
            theme.appBarTheme.foregroundColor ??
            theme.textTheme.bodyLarge?.color,
        elevation: 0,
        title: const Text(
          'Help & Support',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'How can we help you?',
              style: TextStyle(
                color: theme.textTheme.headlineMedium?.color,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Choose an option below to get help.',
              style: TextStyle(
                color: theme.textTheme.bodySmall?.color,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 30),

            HelpTile(
              icon: Icons.quiz_outlined,
              title: 'Frequently Asked Questions',
              subtitle: 'Find answers to common questions',
              onTap: () => _showFaq(context),
            ),

            HelpTile(
              icon: Icons.support_agent_outlined,
              title: 'Contact Support',
              subtitle: 'Get in touch with our support team',
              onTap: () => _showContactSupport(context),
            ),

            HelpTile(
              icon: Icons.bug_report_outlined,
              title: 'Report a Problem',
              subtitle: 'Tell us about a problem you found',
              onTap: () => _showReportProblem(context),
            ),

            HelpTile(
              icon: Icons.info_outline,
              title: 'About Tech Store',
              subtitle: 'Learn more about Tech Store',
              onTap: () => _showAbout(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showFaq(BuildContext context) {
    _showSheet(
      context,
      Icons.quiz_outlined,
      'Frequently Asked Questions',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _Faq(
            'How can I create an account?',
            'Go to the Register page and enter your name, email and password.',
          ),
          _Faq(
            'How can I change my language?',
            'Go to Settings → Language and select English or Arabic.',
          ),
          _Faq(
            'How can I change the app theme?',
            'Go to Settings → Appearance and choose your preferred theme.',
          ),
          _Faq(
            'How can I contact support?',
            'Open Settings → Help & Support → Contact Support.',
          ),
          _Faq(
            'How can I report a problem?',
            'Open Report a Problem and describe the problem you are experiencing.',
          ),
        ],
      ),
    );
  }

  void _showContactSupport(BuildContext context) {
    _showSheet(
      context,
      Icons.support_agent_outlined,
      'Contact Support',
      Column(
        children: const [
          _Contact(
            Icons.email_outlined,
            'Email',
            'support@techstore.com',
          ),
          _Contact(
            Icons.chat_outlined,
            'Live Chat',
            'Chat with our support team',
          ),
          _Contact(
            Icons.phone_outlined,
            'Phone',
            'Contact us by phone',
          ),
        ],
      ),
    );
  }

  void _showReportProblem(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        final theme = Theme.of(context);

        return AlertDialog(
          title: const Text('Report a Problem'),

          content: TextField(
            controller: controller,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Describe the problem...',
              filled: true,
              fillColor: theme.cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Problem reported successfully.'),
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

  void _showAbout(BuildContext context) {
    _showSheet(
      context,
      Icons.info_outline,
      'About Tech Store',
      Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: primaryBlue.withOpacity(.15),
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
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Your one-stop destination for the latest technology products and accessories.',
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 15),

          const Text(
            'Version 1.0.0',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _showSheet(
    BuildContext context,
    IconData icon,
    String title,
    Widget child,
  ) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.cardColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (_) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: primaryBlue,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                child,
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Faq extends StatelessWidget {
  final String question;
  final String answer;

  const _Faq(this.question, this.answer);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            answer,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.color,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _Contact extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _Contact(
    this.icon,
    this.title,
    this.subtitle,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF4C5DFF),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
