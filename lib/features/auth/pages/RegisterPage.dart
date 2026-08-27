import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:tech_store/core/constsnts/AppStrings.dart';
import 'package:tech_store/core/routes/approuter.dart';
import 'package:tech_store/features/auth/cubits/RegisterCubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static const Color primaryBlue = Color(0xFF4C5DFF);

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textColor =
        theme.textTheme.bodyLarge?.color ?? Colors.white;

    final secondaryColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.65) ??
            Colors.grey;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryBlue,
                    ),
                  );
                },
              );
            }

            if (state is RegisterSuccess) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    AppStrings.get(
                      context,
                      en: 'Account created! Check your email and verify your account.',
                      ar: 'تم إنشاء الحساب! تحقق من بريدك الإلكتروني لتفعيل الحساب.',
                    ),
                  ),
                  backgroundColor: Colors.green,
                ),
              );

              context.push(
                AppRouter.verification,
                extra: {
                  'email': emailController.text.trim(),
                  'firstName': firstNameController.text.trim(),
                },
              );
            }

            if (state is RegisterFailure) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }

              final message = state.message.toLowerCase();

              if (message.contains('already') ||
                  message.contains('in use') ||
                  message.contains('email-already-in-use')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppStrings.get(
                        context,
                        en: 'This email already has an account. Please login.',
                        ar: 'هذا البريد الإلكتروني لديه حساب بالفعل. من فضلك قم بتسجيل الدخول.',
                      ),
                    ),
                    backgroundColor: Colors.orange,
                  ),
                );

                Future.delayed(
                  const Duration(milliseconds: 500),
                  () {
                    if (mounted) {
                      context.go(AppRouter.login);
                    }
                  },
                );

                return;
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35),

                Center(
                  child: Text(
                    AppStrings.get(
                      context,
                      en: 'Create Account',
                      ar: 'إنشاء حساب',
                    ),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Center(
                  child: Text(
                    AppStrings.get(
                      context,
                      en: 'Sign up to continue',
                      ar: 'أنشئ حسابك للمتابعة',
                    ),
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        context: context,
                        controller: firstNameController,
                        hint: AppStrings.firstName(context),
                        icon: Icons.person_outline,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _buildTextField(
                        context: context,
                        controller: lastNameController,
                        hint: AppStrings.lastName(context),
                        icon: Icons.person_outline,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                _buildTextField(
                  context: context,
                  controller: emailController,
                  hint: AppStrings.email(context),
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  style: TextStyle(
                    color: textColor,
                  ),
                  decoration: InputDecoration(
                    hintText: AppStrings.password(context),
                    hintStyle: TextStyle(
                      color: secondaryColor,
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: secondaryColor,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: secondaryColor,
                      ),
                    ),
                    filled: true,
                    fillColor: theme.cardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: theme.dividerColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: primaryBlue,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      AppStrings.get(
                        context,
                        en: 'Create Account',
                        ar: 'إنشاء حساب',
                      ),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: theme.dividerColor,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        AppStrings.get(
                          context,
                          en: 'OR',
                          ar: 'أو',
                        ),
                        style: TextStyle(
                          color: secondaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: theme.dividerColor,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton(
                      context,
                      Icons.g_mobiledata,
                    ),
                    const SizedBox(width: 15),
                    _socialButton(
                      context,
                      Icons.facebook,
                    ),
                    const SizedBox(width: 15),
                    _socialButton(
                      context,
                      Icons.apple,
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.get(
                        context,
                        en: 'Already have an account?',
                        ar: 'لديك حساب بالفعل؟',
                      ),
                      style: TextStyle(
                        color: secondaryColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go(AppRouter.login);
                      },
                      child: Text(
                        AppStrings.login(context),
                        style: const TextStyle(
                          color: primaryBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register() {
    if (firstNameController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppStrings.get(
              context,
              en: 'Please fill all fields',
              ar: 'من فضلك املأ جميع البيانات',
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    context.read<RegisterCubit>().register(
          email: emailController.text.trim(),
          password: passwordController.text,
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
        );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final theme = Theme.of(context);

    final textColor =
        theme.textTheme.bodyLarge?.color ?? Colors.white;

    final secondaryColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.65) ??
            Colors.grey;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        color: textColor,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: secondaryColor,
        ),
        prefixIcon: Icon(
          icon,
          color: secondaryColor,
        ),
        filled: true,
        fillColor: theme.cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: theme.dividerColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: primaryBlue,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _socialButton(
    BuildContext context,
    IconData icon,
  ) {
    final theme = Theme.of(context);

    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.dividerColor,
        ),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          color:
              theme.iconTheme.color,
          size: 27,
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}
