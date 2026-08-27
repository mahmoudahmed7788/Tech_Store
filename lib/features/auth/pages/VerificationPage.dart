import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_store/core/routes/approuter.dart';


class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  bool isLoading = false;

  String email = '';
  String firstName = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final extra = GoRouterState.of(context).extra;

    if (extra is Map<String, dynamic>) {
      email = extra['email'] ?? '';
      firstName = extra['firstName'] ?? '';
    }
  }

  // ================= CHECK VERIFICATION =================

  Future<void> checkVerification() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception('User not found');
      }

      await user.reload();

      final updatedUser = FirebaseAuth.instance.currentUser;

      if (updatedUser != null && updatedUser.emailVerified) {
        if (!mounted) return;

        // بعد التحقق → Home
        context.go(AppRouter.home, extra: firstName);
      } else {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please verify your email first.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // ================= RESEND =================

  Future<void> resendEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return;

      await user.sendEmailVerification();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification email sent again.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not resend email: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.mark_email_unread_outlined,
                  color: Color(0xFF4C5DFF),
                  size: 90,
                ),

                const SizedBox(height: 30),

                const Text(
                  'Verify Your Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  'We sent a verification email to\n$email',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),

                const SizedBox(height: 35),

                // ================= CHECK =================
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : checkVerification,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4C5DFF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'I Verified My Email',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 15),

                // ================= RESEND =================
                TextButton(
                  onPressed: resendEmail,
                  child: const Text(
                    'Resend Verification Email',
                    style: TextStyle(color: Color(0xFF4C5DFF)),
                  ),
                ),

                const SizedBox(height: 10),

                TextButton(
                  onPressed: () {
                    context.go(AppRouter.login);
                  },
                  child: const Text(
                    'Go to Login',
                    style: TextStyle(color: Colors.grey),
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
