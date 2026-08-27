import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_store/core/service/productApiService.dart';
import 'package:tech_store/data/reposatory/ProductReposatory.dart';
import 'package:tech_store/features/auth/cubits/RegisterCubit.dart';
import 'package:tech_store/features/auth/pages/Login_Page.dart';
import 'package:tech_store/features/auth/pages/RegisterPage.dart';
import 'package:tech_store/features/auth/pages/Splash_Page.dart';
import 'package:tech_store/features/auth/pages/TwoFactorPage.dart';
import 'package:tech_store/features/auth/pages/VerificationPage.dart';
import 'package:tech_store/features/auth/pages/onboardingPage.dart';
import 'package:tech_store/features/cart/pages/Cartpage.dart';
import 'package:tech_store/features/cart/pages/CheckOutPage.dart';
import 'package:tech_store/features/cart/pages/PaymentMethod.dart';
import 'package:tech_store/features/orders/pages/OrderPage.dart';
import 'package:tech_store/features/orders/pages/OrderProcessPage.dart';
import 'package:tech_store/features/products/cubits/ProductCubit.dart';
import 'package:tech_store/features/settings/pages/HelpPage.dart';
import 'package:tech_store/features/settings/pages/Languagepage.dart';
import 'package:tech_store/features/settings/pages/Privacypage.dart';
import 'package:tech_store/features/settings/pages/ProfilePage.dart';
import 'package:tech_store/features/settings/pages/SettingsPage.dart';
import 'package:tech_store/features/settings/pages/notificationsPage.dart';

// =========================================================
// PAGES
// =========================================================


import 'package:tech_store/features/home/pages/HomePage.dart';



class AppRouter {
  // =========================================================
  // ROUTES
  // =========================================================

  static const String splash = '/';

  static const String onboarding = '/onboarding';

  static const String login = '/login';

  static const String register = '/register';

  static const String verification = '/verification';

  static const String home = '/home';

  // =========================================================
  // SETTINGS
  // =========================================================

  static const String settings = '/settings';

  static const String profile = '/profile';

  static const String notifications = '/notifications';

  static const String security = '/security';

  static const String language = '/language';

  static const String help = '/help';

  static const String twoFactor = '/two-factor';

  static const String paymentMethods = '/payment-methods';

  // =========================================================
  // CART / ORDER
  // =========================================================

  static const String cart = '/cart';

  static const String checkout = '/checkout';

  static const String orderSuccess = '/order-success';

  static const String order = '/order';

  // =========================================================
  // GO ROUTER
  // =========================================================

  static final GoRouter router = GoRouter(
    initialLocation: splash,

    routes: [
      // =====================================================
      // SPLASH
      // =====================================================
      GoRoute(
        path: splash,

        builder: (context, state) {
          return const SplashPage();
        },
      ),

      // =====================================================
      // ONBOARDING
      // =====================================================
      GoRoute(
        path: onboarding,

        builder: (context, state) {
          return const OnboardingPage();
        },
      ),

      // =====================================================
      // LOGIN
      // =====================================================
      GoRoute(
        path: login,

        builder: (context, state) {
          return const LoginPage();
        },
      ),

      // =====================================================
      // REGISTER
      // =====================================================
      GoRoute(
        path: register,

        builder: (context, state) {
          return BlocProvider(
            create: (_) => RegisterCubit(),

            child: const RegisterPage(),
          );
        },
      ),

      // =====================================================
      // VERIFICATION
      // =====================================================
      GoRoute(
        path: verification,

        builder: (context, state) {
          return const VerificationPage();
        },
      ),

      // =====================================================
      // HOME
      // =====================================================
      GoRoute(
        path: home,

        builder: (context, state) {
          final userName = state.extra as String? ?? 'User';

          return BlocProvider(
            create: (_) => ProductCubit(
              repository: ProductRepository(
                apiService: ProductApiService(dio: Dio()),
              ),
            ),
            child: Homepage(userName: userName),
          );
        },
      ),

      // =====================================================
      // SETTINGS
      // =====================================================
      GoRoute(
        path: settings,

        builder: (context, state) {
          final userName = state.extra as String? ?? 'User';

          return SettingsPage(userName: userName);
        },
      ),

      // =====================================================
      // PROFILE
      // =====================================================
      GoRoute(
        path: profile,

        builder: (context, state) {
          final userName = state.extra as String? ?? 'User';

          return ProfilePage(userName: userName);
        },
      ),

      // =====================================================
      // NOTIFICATIONS
      // =====================================================
      GoRoute(
        path: notifications,

        builder: (context, state) {
          return const NotificationsPage();
        },
      ),

      // =====================================================
      // PRIVACY & SECURITY
      // =====================================================
      GoRoute(
        path: security,

        builder: (context, state) {
          return const SecurityPage();
        },
      ),

      // =====================================================
      // LANGUAGE
      // =====================================================
      GoRoute(
        path: '/language',
        builder: (context, state) {
          return const LanguagePage();
        },
      ),

      // =====================================================
      // HELP
      // =====================================================
      GoRoute(
        path: help,

        builder: (context, state) {
          return const HelpPage();
        },
      ),

      // =====================================================
      // TWO FACTOR
      // =====================================================
      GoRoute(
        path: twoFactor,

        builder: (context, state) {
          return const TwoFactorPage();
        },
      ),

      // =====================================================
      // PAYMENT METHODS
      // =====================================================
      GoRoute(
        path: paymentMethods,

        builder: (context, state) {
          return const PaymentMethodsPage();
        },
      ),

      // =====================================================
      // CART
      // =====================================================
      GoRoute(
        path: cart,

        builder: (context, state) {
          return const CartPage();
        },
      ),

      // =====================================================
      // CHECKOUT
      // =====================================================
      GoRoute(
        path: checkout,

        builder: (context, state) {
          return const CheckoutPage();
        },
      ),

      // =====================================================
      // ORDER SUCCESS
      // =====================================================
      GoRoute(
        path: orderSuccess,

        builder: (context, state) {
          return const OrderSuccessPage();
        },
      ),

      // =====================================================
      // ORDER
      // =====================================================
      GoRoute(
        path: order,

        builder: (context, state) {
          return const OrderPage();
        },
      ),
    ],
  );
}
