import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TwoFactorPage extends StatefulWidget {
  const TwoFactorPage({super.key});

  @override
  State<TwoFactorPage> createState() => _TwoFactorPageState();
}

class _TwoFactorPageState extends State<TwoFactorPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController codeController = TextEditingController();

  String? verificationId;

  bool codeSent = false;
  bool loading = false;
  bool enabled = false;

  @override
  void initState() {
    super.initState();
    _checkTwoFactor();
  }

  // ============================================================
  // CHECK 2FA
  // ============================================================

  Future<void> _checkTwoFactor() async {
    final user = _auth.currentUser;

    if (user == null) return;

    try {
      final factors = await user.multiFactor.getEnrolledFactors();

      if (!mounted) return;

      setState(() {
        enabled = factors.isNotEmpty;
      });
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      _showMessage(
        e.message ?? 'Could not check two-factor authentication status',
      );
    } catch (e) {
      if (!mounted) return;

      _showMessage(
        'An error occurred while checking two-factor authentication',
      );
    }
  }

  // ============================================================
  // SEND OTP
  // ============================================================

  Future<void> _sendCode() async {
    final phone = phoneController.text.trim();

    if (phone.isEmpty) {
      _showMessage('Please enter your phone number');
      return;
    }

    if (!phone.startsWith('+')) {
      _showMessage('Use international format, example: +201xxxxxxxxx');
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,

        verificationCompleted: (PhoneAuthCredential credential) {},

        verificationFailed: (FirebaseAuthException e) {
          if (!mounted) return;

          setState(() {
            loading = false;
          });

          _showMessage(e.message ?? 'Phone verification failed');
        },

        codeSent: (String id, int? resendToken) {
          if (!mounted) return;

          setState(() {
            verificationId = id;
            codeSent = true;
            loading = false;
          });

          _showMessage('Verification code sent to your phone');
        },

        codeAutoRetrievalTimeout: (String id) {
          verificationId = id;
        },
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      _showMessage('Something went wrong. Please try again');
    }
  }

  // ============================================================
  // VERIFY OTP
  // ============================================================

  Future<void> _verifyCode() async {
    final code = codeController.text.trim();

    if (verificationId == null) {
      _showMessage('Please request a verification code first');
      return;
    }

    if (code.length != 6) {
      _showMessage('Enter the 6-digit verification code');
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final phoneCredential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: code,
      );

      final assertion = PhoneMultiFactorGenerator.getAssertion(phoneCredential);

      final user = _auth.currentUser;

      if (user == null) {
        if (!mounted) return;

        setState(() {
          loading = false;
        });

        _showMessage('No logged in user');

        return;
      }

      await user.multiFactor.enroll(assertion, displayName: 'Phone Number');

      if (!mounted) return;

      setState(() {
        enabled = true;
        loading = false;
      });

      _showMessage('Two-Factor Authentication enabled successfully');
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      _showMessage(e.message ?? 'Invalid verification code');
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      _showMessage('Verification failed');
    }
  }

  // ============================================================
  // DISABLE 2FA
  // ============================================================

  Future<void> _disableTwoFactor() async {
    final user = _auth.currentUser;

    if (user == null) {
      _showMessage('No logged in user');
      return;
    }

    try {
      final factors = await user.multiFactor.getEnrolledFactors();

      if (factors.isEmpty) {
        if (!mounted) return;

        setState(() {
          enabled = false;
        });

        _showMessage('Two-Factor Authentication is not enabled');

        return;
      }

      if (!mounted) return;

      setState(() {
        loading = true;
      });

      await user.multiFactor.unenroll(multiFactorInfo: factors.first);

      if (!mounted) return;

      setState(() {
        enabled = false;
        loading = false;
        codeSent = false;
        verificationId = null;
        codeController.clear();
      });

      _showMessage('Two-Factor Authentication disabled successfully');
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      _showMessage(e.message ?? 'Could not disable Two-Factor Authentication');
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      _showMessage(
        'An error occurred while disabling Two-Factor Authentication',
      );
    }
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF1A1A1A),
      ),
    );
  }

  // ============================================================
  // UI
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,

        title: const Text(
          'Two-Factor Authentication',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 30),

            const Icon(
              Icons.verified_user_outlined,
              color: Color(0xFF4C5DFF),
              size: 90,
            ),

            const SizedBox(height: 25),

            Text(
              enabled
                  ? 'Two-Factor Authentication is Enabled'
                  : 'Protect Your Account',

              textAlign: TextAlign.center,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              enabled
                  ? 'Your account is protected with an additional verification step.'
                  : 'Add your phone number to protect your account with an additional verification step.',

              textAlign: TextAlign.center,

              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),

            const SizedBox(height: 35),

            if (!enabled) ...[
              TextField(
                controller: phoneController,

                keyboardType: TextInputType.phone,

                style: const TextStyle(color: Colors.white),

                decoration: InputDecoration(
                  hintText: '+201xxxxxxxxx',

                  hintStyle: const TextStyle(color: Colors.grey),

                  labelText: 'Phone Number',

                  labelStyle: const TextStyle(color: Colors.grey),

                  prefixIcon: const Icon(Icons.phone, color: Colors.grey),

                  filled: true,

                  fillColor: const Color(0xFF1A1A1A),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              if (codeSent)
                TextField(
                  controller: codeController,

                  keyboardType: TextInputType.number,

                  maxLength: 6,

                  style: const TextStyle(color: Colors.white),

                  decoration: InputDecoration(
                    hintText: 'Enter OTP',

                    hintStyle: const TextStyle(color: Colors.grey),

                    labelText: 'Verification Code',

                    labelStyle: const TextStyle(color: Colors.grey),

                    prefixIcon: const Icon(
                      Icons.sms_outlined,
                      color: Colors.grey,
                    ),

                    filled: true,

                    fillColor: const Color(0xFF1A1A1A),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: loading
                      ? null
                      : codeSent
                      ? _verifyCode
                      : _sendCode,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4C5DFF),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  child: loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          codeSent ? 'Verify Code' : 'Send Code',

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ] else ...[
              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: loading ? null : _disableTwoFactor,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  child: loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Disable 2FA',

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    codeController.dispose();

    super.dispose();
  }
}
