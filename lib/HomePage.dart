import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_store/core/constsnts/AppStrings.dart';
import 'package:tech_store/data/models/PruductModel.dart';
import 'package:tech_store/features/cart/cubits/CartCubit.dart';
import 'package:tech_store/features/favorites/cubits/FavouriteCubit.dart';
import 'package:tech_store/features/products/cubits/ProductCubit.dart';
import 'package:tech_store/features/products/cubits/ProductState.dart';
import 'package:tech_store/features/settings/cubits/SettingsCubit.dart';
import 'package:tech_store/features/settings/pages/SettingsPage.dart';


class Homepage extends StatefulWidget {
  final String userName;

  const Homepage({
    super.key,
    required this.userName,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static const Color primaryBlue =
      Color(0xFF4C5DFF);

  final PageController _bannerController =
      PageController();

  final TextEditingController _searchController =
      TextEditingController();

  Timer? _autoScrollTimer;

  int currentBanner = 0;
  int currentIndex = 0;
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
    {
      'name': 'All',
      'api': '',
    },
    {
      'name': 'Laptops',
      'api': 'laptops',
    },
    {
      'name': 'Smartphones',
      'api': 'smartphones',
    },
    {
      'name': 'Tablets',
      'api': 'tablets',
    },
    {
      'name': 'Accessories',
      'api': 'mobile-accessories',
    },
    {
      'name': 'Gaming',
      'api': 'gaming',
    },
    {
      'name': 'Wearables',
      'api': 'mens-watches',
    },
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

    _autoScrollTimer = Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
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
          duration: const Duration(
            milliseconds: 500,
          ),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settingsState) {
        final theme = Theme.of(context);

        return Scaffold(
          backgroundColor:
              theme.scaffoldBackgroundColor,

          body: _buildCurrentPage(),

          bottomNavigationBar:
              NavigationBar(
            backgroundColor:
                theme.navigationBarTheme
                        .backgroundColor ??
                    theme.cardColor,

            indicatorColor: primaryBlue,

            selectedIndex: currentIndex,

            onDestinationSelected:
                (index) {
              setState(() {
                currentIndex = index;
              });
            },

            destinations: [
              NavigationDestination(
                icon: Icon(
                  Icons.home_outlined,
                  color: theme
                      .iconTheme
                      .color
                      ?.withOpacity(0.6),
                ),
                selectedIcon:
                    const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                label: AppStrings.get(
                  context,
                  'home',
                ),
              ),

              NavigationDestination(
                icon: Icon(
                  Icons.favorite_border,
                  color: theme
                      .iconTheme
                      .color
                      ?.withOpacity(0.6),
                ),
                selectedIcon:
                    const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                label: AppStrings.get(
                  context,
                  'favorites',
                ),
              ),

              NavigationDestination(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: theme
                      .iconTheme
                      .color
                      ?.withOpacity(0.6),
                ),
                selectedIcon:
                    const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                label: AppStrings.get(
                  context,
                  'cart',
                ),
              ),

              NavigationDestination(
                icon: Icon(
                  Icons.settings_outlined,
                  color: theme
                      .iconTheme
                      .color
                      ?.withOpacity(0.6),
                ),
                selectedIcon:
                    const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                label: AppStrings.get(
                  context,
                  'settings',
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // =========================================================
  // CURRENT PAGE
  // =========================================================

  Widget _buildCurrentPage() {
    switch (currentIndex) {
      case 0:
        return _homePage();

      case 1:
        return _favoritesPage();

      case 2:
        return _cartPage();

      case 3:
        return _settingsPage();

      default:
        return _homePage();
    }
  }

  // =========================================================
  // HOME
  // =========================================================

  Widget _homePage() {
    final theme = Theme.of(context);

    final textColor =
        theme.textTheme.bodyLarge?.color ??
            Colors.white;

    final secondaryColor =
        theme.textTheme.bodyMedium?.color
                ?.withOpacity(0.65) ??
            Colors.grey;

    return SafeArea(
      child: SingleChildScrollView(
        physics:
            const BouncingScrollPhysics(),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 10),

            // =================================================
            // GREETING
            // =================================================

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Text(
                AppStrings.get(
                  context,
                  'helloWelcome',
                ),

                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 13,
                ),
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.only(
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
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            // =================================================
            // BANNERS
            // =================================================

            SizedBox(
              height: 165,

              child: PageView.builder(
                controller:
                    _bannerController,

                itemCount:
                    banners.length,

                onPageChanged:
                    (index) {
                  if (!mounted) return;

                  setState(() {
                    currentBanner =
                        index;
                  });
                },

                itemBuilder:
                    (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 20,
                    ),

                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),

                      child: Image.asset(
                        banners[index],

                        fit: BoxFit.cover,

                        errorBuilder:
                            (
                          context,
                          error,
                          stackTrace,
                        ) {
                          return Container(
                            color:
                                theme.cardColor,

                            child: Icon(
                              Icons
                                  .image_not_supported,
                              color:
                                  secondaryColor,
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
            // DOTS
            // =================================================

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,

              children:
                  List.generate(
                banners.length,
                (index) {
                  final active =
                      currentBanner == index;

                  return AnimatedContainer(
                    duration:
                        const Duration(
                      milliseconds: 250,
                    ),

                    margin:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 3,
                    ),

                    height: 7,

                    width:
                        active ? 20 : 7,

                    decoration:
                        BoxDecoration(
                      color: active
                          ? primaryBlue
                          : theme
                              .dividerColor,

                      borderRadius:
                          BorderRadius.circular(
                        10,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // =================================================
            // SEARCH
            // =================================================

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: TextField(
                controller:
                    _searchController,

                style: TextStyle(
                  color: textColor,
                ),

                onSubmitted:
                    (value) {
                  if (value
                      .trim()
                      .isEmpty) {
                    context
                        .read<ProductCubit>()
                        .getProducts();

                    return;
                  }

                  context
                      .read<ProductCubit>()
                      .searchProducts(
                        value.trim(),
                      );
                },

                decoration:
                    InputDecoration(
                  hintText:
                      AppStrings.get(
                    context,
                    'searchProducts',
                  ),

                  hintStyle:
                      TextStyle(
                    color: secondaryColor,
                  ),

                  prefixIcon:
                      Icon(
                    Icons.search,
                    color: secondaryColor,
                  ),

                  filled: true,

                  fillColor:
                      theme.cardColor,

                  enabledBorder:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      14,
                    ),

                    borderSide:
                        BorderSide(
                      color:
                          theme.dividerColor,
                    ),
                  ),

                  focusedBorder:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      14,
                    ),

                    borderSide:
                        const BorderSide(
                      color: primaryBlue,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // =================================================
            // CATEGORIES
            // =================================================

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Text(
                AppStrings.get(
                  context,
                  'categories',
                ),

                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 14),

            SizedBox(
              height: 42,

              child: ListView.builder(
                scrollDirection:
                    Axis.horizontal,

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                itemCount:
                    categories.length,

                itemBuilder:
                    (context, index) {
                  final category =
                      categories[index];

                  final selected =
                      selectedCategory ==
                          index;

                  return Padding(
                    padding:
                        const EdgeInsets.only(
                      right: 10,
                    ),

                    child:
                        ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory =
                              index;
                        });

                        final api =
                            category['api'] ?? '';

                        if (api.isEmpty) {
                          context
                              .read<ProductCubit>()
                              .getProducts();
                        } else {
                          context
                              .read<ProductCubit>()
                              .getProductsByCategory(
                                api,
                              );
                        }
                      },

                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            selected
                                ? primaryBlue
                                : theme.cardColor,

                        foregroundColor:
                            selected
                                ? Colors.white
                                : textColor,

                        elevation: 0,

                        side: selected
                            ? null
                            : BorderSide(
                                color: theme
                                    .dividerColor,
                              ),

                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 18,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                        ),
                      ),

                      child:
                          Text(
                        category['name'] ??
                            '',
                      ),
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
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Text(
                AppStrings.get(
                  context,
                  'popularProducts',
                ),

                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // =================================================
            // PRODUCTS
            // =================================================

            BlocBuilder<
                ProductCubit,
                ProductState>(
              builder:
                  (context, state) {

                // =============================================
                // LOADING
                // =============================================

                if (state
                    is ProductLoading) {
                  return const SizedBox(
                    height: 250,

                    child: Center(
                      child:
                          CircularProgressIndicator(
                        color: primaryBlue,
                      ),
                    ),
                  );
                }

                // =============================================
                // ERROR
                // =============================================

                if (state
                    is ProductError) {
                  return Padding(
                    padding:
                        const EdgeInsets.all(
                      20,
                    ),

                    child: Column(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 50,
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Text(
                          AppStrings.get(
                            context,
                            'somethingWentWrong',
                          ),

                          style:
                              TextStyle(
                            color:
                                textColor,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Text(
                          state.message,

                          textAlign:
                              TextAlign.center,

                          style:
                              TextStyle(
                            color:
                                secondaryColor,
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        ElevatedButton(
                          onPressed:
                              () {
                            context
                                .read<
                                    ProductCubit>()
                                .getProducts();
                          },

                          child:
                              Text(
                            AppStrings.get(
                              context,
                              'tryAgain',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // =============================================
                // SUCCESS
                // =============================================

                if (state
                    is ProductSuccess) {
                  final products =
                      state.products;

                  if (products.isEmpty) {
                    return SizedBox(
                      height: 200,

                      child: Center(
                        child: Text(
                          AppStrings.get(
                            context,
                            'noProductsFound',
                          ),

                          style:
                              TextStyle(
                            color:
                                secondaryColor,
                          ),
                        ),
                      ),
                    );
                  }

                  return _productsGrid(
                    products,
                  );
                }

                return const SizedBox(
                  height: 200,
                );
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // PRODUCTS GRID
  // =========================================================

  Widget _productsGrid(
    List<ProductModel> products,
  ) {
    final visibleProducts =
        products.length > 6
            ? products.sublist(0, 6)
            : products;

    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 20,
      ),

      child: GridView.builder(
        shrinkWrap: true,

        physics:
            const NeverScrollableScrollPhysics(),

        itemCount:
            visibleProducts.length,

        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,

          crossAxisSpacing: 12,

          mainAxisSpacing: 12,

          // زودنا طول الكارت شوية
          // علشان زرار Add to Cart
          // و Favorite ما يعملوش overflow
          childAspectRatio: 0.58,
        ),

        itemBuilder:
            (context, index) {
          final product =
              visibleProducts[index];

          return _productCard(product);
        },
      ),
    );
  }

  // =========================================================
  // PRODUCT CARD
  // =========================================================

  Widget _productCard(
    ProductModel product,
  ) {
    final theme =
        Theme.of(context);

    return BlocBuilder<FavoritesCubit,
        List<ProductModel>>(
      builder: (context, favorites) {

        final bool isFavorite =
            favorites.any(
          (item) =>
              item.id == product.id,
        );

        return Container(
          decoration: BoxDecoration(
            color: theme.cardColor,

            borderRadius:
                BorderRadius.circular(
              16,
            ),
          ),

          clipBehavior:
              Clip.antiAlias,

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // =================================================
              // IMAGE + FAVORITE
              // =================================================

              SizedBox(
                height: 125,

                width: double.infinity,

                child: Stack(
                  children: [

                    Container(
                      width:
                          double.infinity,

                      height:
                          double.infinity,

                      color: Colors.white,

                      child:
                          Image.network(
                        product.thumbnail,

                        fit:
                            BoxFit.contain,

                        cacheWidth:
                            350,

                        cacheHeight:
                            350,

                        errorBuilder:
                            (
                          context,
                          error,
                          stackTrace,
                        ) {
                          return const Center(
                            child:
                                Icon(
                              Icons
                                  .image_not_supported,
                              color:
                                  Colors.grey,
                              size: 40,
                            ),
                          );
                        },

                        loadingBuilder:
                            (
                          context,
                          child,
                          loadingProgress,
                        ) {
                          if (loadingProgress ==
                              null) {
                            return child;
                          }

                          return const Center(
                            child:
                                CircularProgressIndicator(
                              strokeWidth:
                                  2,
                            ),
                          );
                        },
                      ),
                    ),

                    // =================================================
                    // FAVORITE BUTTON
                    // =================================================

                    Positioned(
                      top: 7,
                      right: 7,

                      child:
                          Material(
                        color: Colors.white
                            .withOpacity(
                          0.92,
                        ),

                        shape:
                            const CircleBorder(),

                        child:
                            IconButton(
                          constraints:
                              const BoxConstraints(
                            minWidth: 34,
                            minHeight: 34,
                            maxWidth: 34,
                            maxHeight: 34,
                          ),

                          padding:
                              EdgeInsets.zero,

                          onPressed: () {
                            context
                                .read<
                                    FavoritesCubit>()
                                .toggleFavorite(
                                  product,
                                );
                          },

                          icon:
                              Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons
                                    .favorite_border,

                            color:
                                isFavorite
                                    ? Colors.red
                                    : Colors.grey,

                            size: 19,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // =================================================
              // PRODUCT INFO
              // =================================================

              Expanded(
                child:
                    Padding(
                  padding:
                      const EdgeInsets.all(
                    9,
                  ),

                  child:
                      Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      // =================================================
                      // TITLE
                      // =================================================

                      Text(
                        product.title,

                        maxLines: 2,

                        overflow:
                            TextOverflow.ellipsis,

                        style:
                            TextStyle(
                          color: theme
                              .textTheme
                              .bodyLarge
                              ?.color,

                          fontSize: 12.5,

                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      // =================================================
                      // RATING
                      // =================================================

                      Row(
                        children: [

                          const Icon(
                            Icons.star,
                            color:
                                Colors.amber,
                            size: 14,
                          ),

                          const SizedBox(
                            width: 3,
                          ),

                          Text(
                            product.rating
                                .toStringAsFixed(
                              1,
                            ),

                            style:
                                TextStyle(
                              color: theme
                                  .textTheme
                                  .bodySmall
                                  ?.color,

                              fontSize:
                                  10.5,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 3,
                      ),

                      // =================================================
                      // PRICE
                      // =================================================

                      Text(
                        '\$${product.price.toStringAsFixed(2)}',

                        maxLines: 1,

                        overflow:
                            TextOverflow.ellipsis,

                        style:
                            const TextStyle(
                          color:
                              primaryBlue,

                          fontSize: 15,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

                      // =================================================
                      // ADD TO CART
                      // =================================================

                      BlocBuilder<CartCubit,
                          List<ProductModel>>(
                        builder:
                            (
                          context,
                          cart,
                        ) {

                          final bool
                              inCart =
                              cart.any(
                            (item) =>
                                item.id ==
                                product.id,
                          );

                          return SizedBox(
                            width:
                                double.infinity,

                            height: 34,

                            child:
                                ElevatedButton(
                              onPressed: () {

                                context
                                    .read<
                                        CartCubit>()
                                    .addToCart(
                                      product,
                                    );

                                ScaffoldMessenger
                                    .of(
                                      context,
                                    )
                                    .hideCurrentSnackBar();

                                ScaffoldMessenger
                                    .of(
                                      context,
                                    )
                                    .showSnackBar(
                                  SnackBar(
                                    duration:
                                        const Duration(
                                      milliseconds:
                                          900,
                                    ),

                                    content:
                                        Text(
                                      AppStrings.get(
                                        context,
                                        'addedToCart',
                                      ),
                                    ),

                                    backgroundColor:
                                        Colors.green,
                                  ),
                                );
                              },

                              style:
                                  ElevatedButton
                                      .styleFrom(
                                backgroundColor:
                                    inCart
                                        ? Colors.green
                                        : primaryBlue,

                                foregroundColor:
                                    Colors.white,

                                elevation:
                                    0,

                                padding:
                                    EdgeInsets.zero,

                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    9,
                                  ),
                                ),
                              ),

                              child:
                                  FittedBox(
                                fit:
                                    BoxFit.scaleDown,

                                child:
                                    Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,

                                  children: [

                                    Icon(
                                      inCart
                                          ? Icons
                                              .check
                                          : Icons
                                              .shopping_cart_outlined,

                                      size:
                                          15,
                                    ),

                                    const SizedBox(
                                      width: 5,
                                    ),

                                    Text(
                                      inCart
                                          ? AppStrings
                                              .get(
                                              context,
                                              'addedToCart',
                                            )
                                          : AppStrings
                                              .get(
                                              context,
                                              'addToCart',
                                            ),

                                      style:
                                          const TextStyle(
                                        fontSize:
                                            11,

                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // =========================================================
  // FAVORITES
  // =========================================================

  Widget _favoritesPage() {
    final theme =
        Theme.of(context);

    final textColor =
        theme.textTheme.bodyLarge?.color ??
            Colors.white;

    final secondaryColor =
        theme.textTheme.bodyMedium?.color
                ?.withOpacity(0.65) ??
            Colors.grey;

    return SafeArea(
      child:
          BlocBuilder<FavoritesCubit,
              List<ProductModel>>(
        builder:
            (context, favorites) {

          // =================================================
          // EMPTY
          // =================================================

          if (favorites.isEmpty) {
            return Center(
              child:
                  Padding(
                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 30,
                ),

                child:
                    Column(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,

                  children: [

                    const Icon(
                      Icons
                          .favorite_border,
                      color:
                          primaryBlue,
                      size: 80,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      AppStrings.get(
                        context,
                        'favorites',
                      ),

                      style:
                          TextStyle(
                        color:
                            textColor,
                        fontSize:
                            26,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      AppStrings.get(
                        context,
                        'favoriteEmpty',
                      ),

                      textAlign:
                          TextAlign.center,

                      style:
                          TextStyle(
                        color:
                            secondaryColor,
                        fontSize:
                            14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // =================================================
          // FAVORITES GRID
          // =================================================

          return Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Padding(
                padding:
                    const EdgeInsets
                        .fromLTRB(
                  20,
                  20,
                  20,
                  15,
                ),

                child:
                    Text(
                  AppStrings.get(
                    context,
                    'favorites',
                  ),

                  style:
                      TextStyle(
                    color:
                        textColor,
                    fontSize:
                        26,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                child:
                    GridView.builder(
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),

                  itemCount:
                      favorites.length,

                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        2,

                    crossAxisSpacing:
                        12,

                    mainAxisSpacing:
                        12,

                    childAspectRatio:
                        0.58,
                  ),

                  itemBuilder:
                      (context, index) {
                    return _favoriteCard(
                      favorites[index],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // =========================================================
  // FAVORITE CARD
  // =========================================================

  Widget _favoriteCard(
    ProductModel product,
  ) {
    final theme =
        Theme.of(context);

    return Container(
      decoration:
          BoxDecoration(
        color:
            theme.cardColor,

        borderRadius:
            BorderRadius.circular(
          16,
        ),
      ),

      clipBehavior:
          Clip.antiAlias,

      child:
          Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          SizedBox(
            height: 125,

            width:
                double.infinity,

            child:
                Stack(
              children: [

                Container(
                  width:
                      double.infinity,

                  color:
                      Colors.white,

                  child:
                      Image.network(
                    product.thumbnail,

                    fit:
                        BoxFit.contain,

                    errorBuilder:
                        (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return const Center(
                        child:
                            Icon(
                          Icons
                              .image_not_supported,
                          color:
                              Colors.grey,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),

                Positioned(
                  top: 7,
                  right: 7,

                  child:
                      Material(
                    color:
                        Colors.white,

                    shape:
                        const CircleBorder(),

                    child:
                        IconButton(
                      constraints:
                          const BoxConstraints(
                        minWidth: 34,
                        minHeight: 34,
                        maxWidth: 34,
                        maxHeight: 34,
                      ),

                      padding:
                          EdgeInsets.zero,

                      onPressed: () {
                        context
                            .read<
                                FavoritesCubit>()
                            .toggleFavorite(
                              product,
                            );
                      },

                      icon:
                          const Icon(
                        Icons.favorite,
                        color:
                            Colors.red,
                        size: 19,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child:
                Padding(
              padding:
                  const EdgeInsets.all(
                9,
              ),

              child:
                  Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    product.title,

                    maxLines:
                        2,

                    overflow:
                        TextOverflow.ellipsis,

                    style:
                        TextStyle(
                      color: theme
                          .textTheme
                          .bodyLarge
                          ?.color,

                      fontSize:
                          12.5,

                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    '\$${product.price.toStringAsFixed(2)}',

                    style:
                        const TextStyle(
                      color:
                          primaryBlue,

                      fontSize:
                          15,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 6,
                  ),

                  SizedBox(
                    width:
                        double.infinity,

                    height:
                        34,

                    child:
                        ElevatedButton(
                      onPressed: () {
                        context
                            .read<
                                CartCubit>()
                            .addToCart(
                              product,
                            );

                        ScaffoldMessenger
                            .of(
                              context,
                            )
                            .hideCurrentSnackBar();

                        ScaffoldMessenger
                            .of(
                              context,
                            )
                            .showSnackBar(
                          SnackBar(
                            duration:
                                const Duration(
                              milliseconds:
                                  900,
                            ),

                            content:
                                Text(
                              AppStrings.get(
                                context,
                                'addedToCart',
                              ),
                            ),

                            backgroundColor:
                                Colors.green,
                          ),
                        );
                      },

                      style:
                          ElevatedButton
                              .styleFrom(
                        backgroundColor:
                            primaryBlue,

                        foregroundColor:
                            Colors.white,

                        elevation:
                            0,

                        padding:
                            EdgeInsets.zero,

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                            9,
                          ),
                        ),
                      ),

                      child:
                          FittedBox(
                        child:
                            Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .center,

                          children: [

                            const Icon(
                              Icons
                                  .shopping_cart_outlined,
                              size: 15,
                            ),

                            const SizedBox(
                              width: 5,
                            ),

                            Text(
                              AppStrings.get(
                                context,
                                'addToCart',
                              ),

                              style:
                                  const TextStyle(
                                fontSize:
                                    11,

                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // CART
  // =========================================================

  Widget _cartPage() {
  final theme = Theme.of(context);
  final cart = context.watch<CartCubit>().state;

  final textColor =
      theme.textTheme.bodyLarge?.color ?? Colors.white;

  final secondaryColor =
      theme.textTheme.bodyMedium?.color?.withOpacity(0.65) ??
          Colors.grey;

  if (cart.isEmpty) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              color: primaryBlue,
              size: 80,
            ),
            const SizedBox(height: 20),
            Text(
              AppStrings.get(context, 'yourCart'),
              style: TextStyle(
                color: textColor,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.get(context, 'cartEmpty'),
              style: TextStyle(
                color: secondaryColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final cartCubit = context.read<CartCubit>();
  final total = cartCubit.getTotal();

  return SafeArea(
    child: Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: cart.length,
            itemBuilder: (context, index) {
              final product = cart[index];
              final quantity =
                  cartCubit.getQuantity(product);

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      child: Image.network(
                        product.thumbnail,
                        fit: BoxFit.contain,
                        errorBuilder:
                            (_, __, ___) {
                          return const Icon(
                            Icons.image_not_supported,
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            maxLines: 2,
                            overflow:
                                TextOverflow.ellipsis,
                            style: TextStyle(
                              color: textColor,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: primaryBlue,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  cartCubit
                                      .decreaseQuantity(
                                    product,
                                  );
                                },
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                ),
                              ),

                              Text(
                                '$quantity',
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              IconButton(
                                onPressed: () {
                                  cartCubit
                                      .increaseQuantity(
                                    product,
                                  );
                                },
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                ),
                              ),

                              const Spacer(),

                              IconButton(
                                onPressed: () {
                                  cartCubit
                                      .removeFromCart(
                                    product,
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // ================= TOTAL + CHECKOUT =================

        Container(
          padding: const EdgeInsets.fromLTRB(
            20,
            15,
            20,
            20,
          ),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: primaryBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/checkout');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Checkout',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  // =========================================================
  // SETTINGS
  // =========================================================

  Widget _settingsPage() {
    return SettingsPage(
      userName: widget.userName,
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