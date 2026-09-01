import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tech_store/core/constsnts/AppStrings.dart';
import 'package:tech_store/features/products/cubits/ProductCubit.dart';
import 'package:tech_store/features/products/cubits/ProductState.dart';
import 'package:tech_store/features/home/widgets/ProductGrid.dart';

class HomeTab extends StatefulWidget {
  final String userName;

  const HomeTab({super.key, required this.userName});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  static const Color primaryBlue = Color(0xFF4C5DFF);

  final PageController _bannerController = PageController();

  final TextEditingController _searchController = TextEditingController();

  Timer? _autoScrollTimer;

  int currentBanner = 0;
  int selectedCategory = 0;

  // =========================================================
  // BANNERS
  // =========================================================

  final List<String> banners = [
    'assets/image/Banner1.avif',
    'assets/image/banner2.jpg',
    'assets/image/banner3.jpg',
    'assets/image/banner4.jpg',
    'assets/image/banner5.jpg',
  ];

  // =========================================================
  // CATEGORIES
  // =========================================================

  final List<Map<String, String>> categories = [
    {'name': 'All', 'api': ''},
    {'name': 'Laptops', 'api': 'laptops'},
    {'name': 'Smartphones', 'api': 'smartphones'},
    {'name': 'Tablets', 'api': 'tablets'},
    {'name': 'Accessories', 'api': 'mobile-accessories'},
    {'name': 'Gaming', 'api': 'gaming'},
    {'name': 'Wearables', 'api': 'mens-watches'},
  ];

  // =========================================================
  // INIT
  // =========================================================

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<ProductCubit>().getProducts();
    });

    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) return;

      if (!_bannerController.hasClients) {
        return;
      }

      int nextPage = currentBanner + 1;

      if (nextPage >= banners.length) {
        nextPage = 0;
      }

      _bannerController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;

    final secondaryColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.65) ?? Colors.grey;

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // =================================================
            // GREETING
            // =================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                AppStrings.get(context, en: 'Hello Welcome', ar: 'مرحبا بك'),
                style: TextStyle(color: secondaryColor, fontSize: 13),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 4,
                bottom: 18,
              ),
              child: Text(
                widget.userName,
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // =================================================
            // BANNERS
            // =================================================
            SizedBox(
              height: 165,
              child: PageView.builder(
                controller: _bannerController,
                itemCount: banners.length,
                onPageChanged: (index) {
                  if (!mounted) return;

                  setState(() {
                    currentBanner = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        banners[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: theme.cardColor,
                            child: Icon(
                              Icons.image_not_supported,
                              color: secondaryColor,
                              size: 40,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // =================================================
            // BANNER DOTS
            // =================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(banners.length, (index) {
                final active = currentBanner == index;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  height: 7,
                  width: active ? 20 : 7,
                  decoration: BoxDecoration(
                    color: active ? primaryBlue : theme.dividerColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            // =================================================
            // SEARCH
            // =================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: textColor),
                onSubmitted: (value) {
                  final query = value.trim();

                  if (query.isEmpty) {
                    context.read<ProductCubit>().getProducts();
                    return;
                  }

                  context.read<ProductCubit>().searchProducts(query);
                },
                decoration: InputDecoration(
                  hintText: AppStrings.searchProducts(context),
                  hintStyle: TextStyle(color: secondaryColor),
                  prefixIcon: Icon(Icons.search, color: secondaryColor),
                  filled: true,
                  fillColor: theme.cardColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: theme.dividerColor),
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
            ),

            const SizedBox(height: 30),

            // =================================================
            // CATEGORIES TITLE
            // =================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                AppStrings.get(context, en: 'categories', ar: 'الفئات'),
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 14),

            // =================================================
            // CATEGORIES
            // =================================================
            SizedBox(
              height: 42,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];

                  final selected = selectedCategory == index;

                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = index;
                        });

                        final api = category['api'] ?? '';

                        if (api.isEmpty) {
                          context.read<ProductCubit>().getProducts();
                        } else {
                          context.read<ProductCubit>().getProductsByCategory(
                            api,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selected
                            ? primaryBlue
                            : theme.cardColor,
                        foregroundColor: selected ? Colors.white : textColor,
                        elevation: 0,
                        side: selected
                            ? null
                            : BorderSide(color: theme.dividerColor),
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(category['name'] ?? ''),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // =================================================
            // PRODUCTS TITLE
            // =================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                AppStrings.get(
                  context,
                  en: 'Popular Products',
                  ar: 'المنتجات الشهيرة',
                ),
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // =================================================
            // PRODUCTS
            // =================================================
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                // LOADING
                if (state is ProductLoading) {
                  return const SizedBox(
                    height: 250,
                    child: Center(
                      child: CircularProgressIndicator(color: primaryBlue),
                    ),
                  );
                }

                // ERROR
                if (state is ProductError) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 50,
                        ),

                        const SizedBox(height: 10),

                        Text(
                          AppStrings.get(
                            context,
                            en: 'Something went wrong',
                            ar: 'حدث خطأ ما',
                          ),
                          style: TextStyle(color: textColor, fontSize: 16),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: secondaryColor),
                        ),

                        const SizedBox(height: 15),

                        ElevatedButton(
                          onPressed: () {
                            context.read<ProductCubit>().getProducts();
                          },
                          child: Text(
                            AppStrings.get(
                              context,
                              en: 'Try Again',
                              ar: 'حاول مجددا',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // SUCCESS
                if (state is ProductSuccess) {
                  final products = state.products;

                  if (products.isEmpty) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: Text(
                          AppStrings.get(
                            context,
                            en: 'No products found',
                            ar: 'لا توجد منتجات',
                          ),
                          style: TextStyle(color: secondaryColor),
                        ),
                      ),
                    );
                  }

                  return ProductGrid(products: products);
                }

                return const SizedBox(height: 200);
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _bannerController.dispose();
    _searchController.dispose();

    super.dispose();
  }
}
