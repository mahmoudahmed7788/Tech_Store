import 'package:flutter/material.dart';

import 'package:tech_store/core/constsnts/AppStrings.dart';
import 'package:tech_store/features/home/pages/CartTab.dart';
import 'package:tech_store/features/home/pages/FavoriteTabs.dart';
import 'package:tech_store/features/home/pages/HomaTab.dart';
import 'package:tech_store/features/settings/pages/SettingsPage.dart';

class Homepage extends StatefulWidget {
  final String userName;

  const Homepage({super.key, required this.userName});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static const Color primaryBlue = Color(0xFF4C5DFF);

  int currentIndex = 0;

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: _buildCurrentPage(),

      bottomNavigationBar: NavigationBar(
        backgroundColor:
            theme.navigationBarTheme.backgroundColor ?? theme.cardColor,

        indicatorColor: primaryBlue,

        selectedIndex: currentIndex,

        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        destinations: [
          // =====================================================
          // HOME
          // =====================================================
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: theme.iconTheme.color?.withOpacity(0.6),
            ),
            selectedIcon: const Icon(Icons.home, color: Colors.white),
            label: AppStrings.get(context, en: 'home', ar: 'الرئيسية'),
          ),

          // =====================================================
          // FAVORITES
          // =====================================================
          NavigationDestination(
            icon: Icon(
              Icons.favorite_border,
              color: theme.iconTheme.color?.withOpacity(0.6),
            ),
            selectedIcon: const Icon(Icons.favorite, color: Colors.white),
            label: AppStrings.get(context, en: 'favorites', ar: 'المفضلة'),
          ),

          // =====================================================
          // CART
          // =====================================================
          NavigationDestination(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: theme.iconTheme.color?.withOpacity(0.6),
            ),
            selectedIcon: const Icon(Icons.shopping_cart, color: Colors.white),
            label: AppStrings.get(context, en: 'cart', ar: 'السلة'),
          ),

          // =====================================================
          // SETTINGS
          // =====================================================
          NavigationDestination(
            icon: Icon(
              Icons.settings_outlined,
              color: theme.iconTheme.color?.withOpacity(0.6),
            ),
            selectedIcon: const Icon(Icons.settings, color: Colors.white),
            label: AppStrings.get(context, en: 'settings', ar: 'الإعدادات'),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // CURRENT PAGE
  // =========================================================

  Widget _buildCurrentPage() {
    switch (currentIndex) {
      case 0:
        return HomeTab(userName: widget.userName);

      case 1:
        return const FavoritesTab();

      case 2:
        return const CartTab();

      case 3:
        return SettingsPage(userName: widget.userName);

      default:
        return HomeTab(userName: widget.userName);
    }
  }
}
