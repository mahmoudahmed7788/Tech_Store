import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:tech_store/core/constsnts/AppStrings.dart';
import 'package:tech_store/core/constsnts/DeviceService.dart';
import 'package:tech_store/core/routes/approuter.dart';
import 'package:tech_store/core/service/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const Color primaryBlue = Color(0xFF4C5DFF);

  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final AuthService _authService = AuthService();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textColor =
        theme.textTheme.bodyLarge?.color ??
            Colors.white;

    final secondaryColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.65) ??
            Colors.grey;

    return Scaffold(
      backgroundColor:
          theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor:
            theme.scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: textColor,
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(
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

                Text(
                  AppStrings.get(
                    context,
                    en: 'Welcome Back',
                    ar: 'مرحباً بعودتك',
                  ),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,
                    color: textColor,
                  ),
                ),

                const SizedBox(height: 25),

                // =================================================
                // ACCOUNT ICON
                // =================================================

                Icon(
                  Icons.account_circle,
                  size: 100,
                  color: textColor,
                ),

                const SizedBox(height: 10),

                Text(
                  AppStrings.get(
                    context,
                    en: 'Login Account with',
                    ar: 'تسجيل الدخول باستخدام',
                  ),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:
                        FontWeight.w500,
                    color: textColor,
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
                      icon: Icon(
                        Icons.facebook,
                        size: 40,
                        color: textColor,
                      ),
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.email,
                        size: 40,
                        color: textColor,
                      ),
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.g_mobiledata,
                        size: 55,
                        color: textColor,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // =================================================
                // EMAIL LABEL
                // =================================================

                Align(
                  alignment:
                      AlignmentDirectional
                          .centerStart,

                  child: Text(
                    AppStrings.email(context),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // =================================================
                // EMAIL
                // =================================================

                TextFormField(
                  controller:
                      emailController,

                  keyboardType:
                      TextInputType.emailAddress,

                  style: TextStyle(
                    color: textColor,
                  ),

                  decoration:
                      _inputDecoration(
                    context,
                    hint: AppStrings.get(
                      context,
                      en: 'Enter your email',
                      ar: 'أدخل بريدك الإلكتروني',
                    ),
                    icon:
                        Icons.email_outlined,
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return AppStrings.get(
                        context,
                        en: 'Please enter your email',
                        ar: 'من فضلك أدخل بريدك الإلكتروني',
                      );
                    }

                    final emailRegex =
                        RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );

                    if (!emailRegex
                        .hasMatch(
                      value.trim(),
                    )) {
                      return AppStrings.get(
                        context,
                        en: 'Please enter a valid email',
                        ar: 'من فضلك أدخل بريد إلكتروني صحيح',
                      );
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // =================================================
                // PASSWORD LABEL
                // =================================================

                Align(
                  alignment:
                      AlignmentDirectional
                          .centerStart,

                  child: Text(
                    AppStrings.password(context),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // =================================================
                // PASSWORD
                // =================================================

                TextFormField(
                  controller:
                      passwordController,

                  obscureText:
                      obscurePassword,

                  style: TextStyle(
                    color: textColor,
                  ),

                  decoration:
                      _inputDecoration(
                    context,
                    hint: AppStrings.get(
                      context,
                      en: 'Enter your password',
                      ar: 'أدخل كلمة المرور',
                    ),
                    icon:
                        Icons.lock_outline,
                    suffixIcon:
                        IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword =
                              !obscurePassword;
                        });
                      },

                      icon: Icon(
                        obscurePassword
                            ? Icons
                                .visibility_off
                            : Icons
                                .visibility,
                        color:
                            secondaryColor,
                      ),
                    ),
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return AppStrings.get(
                        context,
                        en: 'Please enter your password',
                        ar: 'من فضلك أدخل كلمة المرور',
                      );
                    }

                    if (value.length < 6) {
                      return AppStrings.get(
                        context,
                        en: 'Password must be at least 6 characters',
                        ar: 'كلمة المرور يجب أن تكون 6 أحرف على الأقل',
                      );
                    }

                    if (!RegExp(
                      r'[A-Za-z]',
                    ).hasMatch(value)) {
                      return AppStrings.get(
                        context,
                        en: 'Password must contain a letter',
                        ar: 'كلمة المرور يجب أن تحتوي على حرف',
                      );
                    }

                    if (!RegExp(
                      r'[0-9]',
                    ).hasMatch(value)) {
                      return AppStrings.get(
                        context,
                        en: 'Password must contain a number',
                        ar: 'كلمة المرور يجب أن تحتوي على رقم',
                      );
                    }

                    if (!RegExp(
                      r'[!@#$%^&*(),.?":{}|<>_\-]',
                    ).hasMatch(value)) {
                      return AppStrings.get(
                        context,
                        en: 'Password must contain a special character',
                        ar: 'كلمة المرور يجب أن تحتوي على رمز خاص',
                      );
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
                          primaryBlue,
                      foregroundColor:
                          Colors.white,
                      elevation: 0,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),

                    child: Text(
                      AppStrings.login(context),
                      style:
                          const TextStyle(
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
                    Flexible(
                      child: Text(
                        AppStrings.get(
                          context,
                          en: 'Want to create an account? ',
                          ar: 'هل تريد إنشاء حساب؟ ',
                        ),
                        style: TextStyle(
                          color:
                              secondaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        context.go(
                          AppRouter.register,
                        );
                      },

                      child: Text(
                        AppStrings.get(
                          context,
                          en: 'Sign Up',
                          ar: 'إنشاء حساب',
                        ),
                        style:
                            const TextStyle(
                          color:
                              primaryBlue,
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

  // =============================================================
  // INPUT DECORATION
  // =============================================================

  InputDecoration _inputDecoration(
    BuildContext context, {
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    final theme =
        Theme.of(context);

    final secondaryColor =
        theme.textTheme.bodyMedium?.color
                ?.withOpacity(0.65) ??
            Colors.grey;

    return InputDecoration(
      hintText: hint,

      hintStyle: TextStyle(
        color: secondaryColor,
      ),

      prefixIcon: Icon(
        icon,
        color: secondaryColor,
      ),

      suffixIcon: suffixIcon,

      filled: true,

      fillColor:
          theme.cardColor,

      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),

        borderSide:
            BorderSide(
          color:
              theme.dividerColor,
        ),
      ),

      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),

        borderSide:
            const BorderSide(
          color: primaryBlue,
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
    );
  }

  // =============================================================
  // LOGIN
  // =============================================================

  Future<void> _login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      // =========================================================
      // LOADING
      // =========================================================

      showDialog(
        context: context,
        barrierDismissible: false,

        builder: (_) {
          return const Center(
            child:
                CircularProgressIndicator(
              color: primaryBlue,
            ),
          );
        },
      );

      // =========================================================
      // FIREBASE LOGIN
      // =========================================================

      final credential =
          await _authService.login(
        email:
            emailController.text.trim(),
        password:
            passwordController.text,
      );

      final user =
          credential.user;

      // =========================================================
      // REGISTER DEVICE
      // =========================================================

      if (user != null) {
        await DeviceService
            .registerDevice();
      }

      if (!mounted) return;

      // =========================================================
      // CLOSE LOADING
      // =========================================================

      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      // =========================================================
      // USER CHECK
      // =========================================================

      if (user == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            content: Text(
              AppStrings.get(
                context,
                en: 'Login failed.',
                ar: 'فشل تسجيل الدخول.',
              ),
            ),
            backgroundColor:
                Colors.red,
          ),
        );

        return;
      }

      // =========================================================
      // USER NAME
      // =========================================================

      final userName =
          user.displayName ?? 'User';

      // =========================================================
      // GO HOME
      // =========================================================

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

      final message =
          _getLoginErrorMessage(
        context,
        e.code,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content:
              Text(message),
          backgroundColor:
              Colors.red,
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

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            AppStrings.get(
              context,
              en: 'Something went wrong.',
              ar: 'حدث خطأ ما.',
            ),
          ),
          backgroundColor:
              Colors.red,
        ),
      );
    }
  }

  // =============================================================
  // LOGIN ERROR MESSAGE
  // =============================================================

  String _getLoginErrorMessage(
    BuildContext context,
    String code,
  ) {
    switch (code) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
        return AppStrings.get(
          context,
          en: 'Email or password is incorrect.',
          ar: 'البريد الإلكتروني أو كلمة المرور غير صحيحة.',
        );

      case 'invalid-email':
        return AppStrings.get(
          context,
          en: 'Please enter a valid email.',
          ar: 'من فضلك أدخل بريد إلكتروني صحيح.',
        );

      case 'user-disabled':
        return AppStrings.get(
          context,
          en: 'This account has been disabled.',
          ar: 'هذا الحساب تم تعطيله.',
        );

      case 'network-request-failed':
        return AppStrings.get(
          context,
          en: 'Please check your internet connection.',
          ar: 'من فضلك تحقق من اتصال الإنترنت.',
        );

      case 'too-many-requests':
        return AppStrings.get(
          context,
          en: 'Too many attempts. Please try again later.',
          ar: 'محاولات كثيرة جداً. حاول مرة أخرى لاحقاً.',
        );

      default:
        return AppStrings.get(
          context,
          en: 'Login failed. Please try again.',
          ar: 'فشل تسجيل الدخول. حاول مرة أخرى.',
        );
    }
  }

  // =============================================================
  // DISPOSE
  // =============================================================

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
