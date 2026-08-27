import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:tech_store/core/constsnts/DeviceService.dart';
import 'package:tech_store/core/routes/approuter.dart';
import 'package:tech_store/core/service/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final AuthService _authService = AuthService();

  bool obscurePassword = true;

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),

                // =================================================
                // TITLE
                // =================================================

                const Text(
                  'Welcome Back ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 25),

                // =================================================
                // ACCOUNT ICON
                // =================================================

                const Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.white,
                ),

                const SizedBox(height: 10),

                const Text(
                  'Login Account with',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 12),

                // =================================================
                // SOCIAL ICONS
                // =================================================

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.facebook,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.email,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.g_mobiledata,
                        size: 55,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // =================================================
                // EMAIL LABEL
                // =================================================

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // =================================================
                // EMAIL
                // =================================================

                TextFormField(
                  controller: emailController,
                  keyboardType:
                      TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor:
                        const Color(0xFF1A1A1A),
                    enabledBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                      borderSide:
                          const BorderSide(
                        color: Color(0xFF333333),
                      ),
                    ),
                    focusedBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                      borderSide:
                          const BorderSide(
                        color: Color(0xFF4C5DFF),
                        width: 2,
                      ),
                    ),
                    errorBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                      borderSide:
                          const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                      borderSide:
                          const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );

                    if (!emailRegex.hasMatch(
                      value.trim(),
                    )) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // =================================================
                // PASSWORD LABEL
                // =================================================

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // =================================================
                // PASSWORD
                // =================================================

                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword =
                              !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                    ),
                    filled: true,
                    fillColor:
                        const Color(0xFF1A1A1A),
                    enabledBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                      borderSide:
                          const BorderSide(
                        color: Color(0xFF333333),
                      ),
                    ),
                    focusedBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                      borderSide:
                          const BorderSide(
                        color: Color(0xFF4C5DFF),
                        width: 2,
                      ),
                    ),
                    errorBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                      borderSide:
                          const BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                      borderSide:
                          const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please enter your password';
                    }

                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }

                    if (!RegExp(r'[A-Za-z]')
                        .hasMatch(value)) {
                      return 'Password must contain a letter';
                    }

                    if (!RegExp(r'[0-9]')
                        .hasMatch(value)) {
                      return 'Password must contain a number';
                    }

                    if (!RegExp(
                      r'[!@#$%^&*(),.?":{}|<>_\-]',
                    ).hasMatch(value)) {
                      return 'Password must contain a special character';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // =================================================
                // LOGIN BUTTON
                // =================================================

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _login,
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF4C5DFF),
                      foregroundColor:
                          Colors.white,
                      elevation: 0,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // =================================================
                // REGISTER
                // =================================================

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Want to create an account? ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.go(
                          AppRouter.register,
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color:
                              Color(0xFF4C5DFF),
                          fontSize: 14,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // LOGIN
  // =========================================================

  Future<void> _login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      // =======================================================
      // LOADING
      // =======================================================

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF4C5DFF),
            ),
          );
        },
      );

      // =======================================================
      // FIREBASE LOGIN THROUGH AUTH SERVICE
      // =======================================================

      final credential = await _authService.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final user = credential.user;

      // =======================================================
      // REGISTER DEVICE
      // =======================================================

      if (user != null) {
        await DeviceService.registerDevice();
      }

      if (!mounted) return;

      // =======================================================
      // CLOSE LOADING
      // =======================================================

      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      // =======================================================
      // CHECK USER
      // =======================================================

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed.'),
            backgroundColor: Colors.red,
          ),
        );

        return;
      }

      // =======================================================
      // USER NAME
      // =======================================================

      final userName =
          user.displayName ?? 'User';

      // =======================================================
      // GO HOME
      // =======================================================

      context.go(
        AppRouter.home,
        extra: userName,
      );
    }

    // =========================================================
    // FIREBASE ERROR
    // =========================================================

    on FirebaseAuthException catch (e) {
      if (!mounted) return;

      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      final message = _getLoginErrorMessage(
        e.code,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }

    // =========================================================
    // GENERAL ERROR
    // =========================================================

    catch (e) {
      if (!mounted) return;

      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Something went wrong.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // =========================================================
  // LOGIN ERROR MESSAGE
  // =========================================================

  String _getLoginErrorMessage(String code) {
    switch (code) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
        return 'Email or password is incorrect.';

      case 'invalid-email':
        return 'Please enter a valid email.';

      case 'user-disabled':
        return 'This account has been disabled.';

      case 'network-request-failed':
        return 'Please check your internet connection.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      default:
        return 'Login failed. Please try again.';
    }
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}