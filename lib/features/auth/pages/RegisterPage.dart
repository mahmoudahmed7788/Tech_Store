import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_store/core/routes/approuter.dart';
import 'package:tech_store/features/auth/cubits/RegisterCubit.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {

            // ================= LOADING =================

            if (state is RegisterLoading) {
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
            }

            // ================= SUCCESS =================

            if (state is RegisterSuccess) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Account created! Check your email and verify your account.',
                  ),
                  backgroundColor: Colors.green,
                ),
              );

              // نبعت الإيميل + الاسم للـ Verification
              context.push(
                AppRouter.verification,
                extra: {
                  'email': emailController.text.trim(),
                  'firstName': firstNameController.text.trim(),
                },
              );
            }

            // ================= FAILURE =================

            if (state is RegisterFailure) {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }

              final message = state.message.toLowerCase();

              // لو الإيميل موجود بالفعل
              if (message.contains('already') ||
                  message.contains('in use') ||
                  message.contains('email-already-in-use')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'This email already has an account. Please login.',
                    ),
                    backgroundColor: Colors.orange,
                  ),
                );

                // يروح Login
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

              // أي Error تاني
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

                // ================= TITLE =================

                const Center(
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const Center(
                  child: Text(
                    'Sign up to continue',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                // ================= FIRST + LAST NAME =================

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: firstNameController,
                        hint: 'First Name',
                        icon: Icons.person_outline,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _buildTextField(
                        controller: lastNameController,
                        hint: 'Last Name',
                        icon: Icons.person_outline,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // ================= EMAIL =================

                _buildTextField(
                  controller: emailController,
                  hint: 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 16),

                // ================= PASSWORD =================

                TextFormField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Password',
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
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    filled: true,
                    fillColor: const Color(0xFF1A1A1A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // ================= REGISTER BUTTON =================

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4C5DFF),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // ================= OR =================

                Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        color: Color(0xFF333333),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0xFF333333),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // ================= SOCIAL =================

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton(
                      icon: Icons.g_mobiledata,
                    ),

                    const SizedBox(width: 15),

                    _socialButton(
                      icon: Icons.facebook,
                    ),

                    const SizedBox(width: 15),

                    _socialButton(
                      icon: Icons.apple,
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // ================= LOGIN =================

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        context.go(AppRouter.login);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFF4C5DFF),
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

  // ================= REGISTER =================

  void _register() {
    if (firstNameController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
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

  // ================= TEXT FIELD =================

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.grey,
        ),
        filled: true,
        fillColor: const Color(0xFF1A1A1A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ================= SOCIAL =================

  static Widget _socialButton({
    required IconData icon,
  }) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF333333),
        ),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          color: Colors.white,
          size: 27,
        ),
      ),
    );
  }

  // ================= DISPOSE =================

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}