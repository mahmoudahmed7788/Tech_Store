import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:tech_store/core/constsnts/firebase_options.dart';
import 'package:tech_store/core/routes/approuter.dart';
import 'package:tech_store/core/service/productApiService.dart';
import 'package:tech_store/core/theme/app_theme.dart';

import 'package:tech_store/data/reposatory/ProductReposatory.dart';

import 'package:tech_store/features/cart/cubits/CartCubit.dart';
import 'package:tech_store/features/favorites/cubits/FavouriteCubit.dart';
import 'package:tech_store/features/products/cubits/ProductCubit.dart';
import 'package:tech_store/features/settings/cubits/SettingsCubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // =========================================================
  // FIREBASE
  // =========================================================

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // =========================================================
  // PRODUCT DEPENDENCIES
  // =========================================================

  final dio = Dio();

  final productApiService = ProductApiService(
    dio: dio,
  );

  final productRepository = ProductRepository(
    apiService: productApiService,
  );

  // =========================================================
  // RUN APP
  // =========================================================

  runApp(
    MultiBlocProvider(
      providers: [
        // =====================================================
        // CART
        // =====================================================

        BlocProvider<CartCubit>(
          create: (_) => CartCubit(),
        ),

        // =====================================================
        // FAVORITES
        // =====================================================

        BlocProvider<FavoritesCubit>(
          create: (_) => FavoritesCubit(),
        ),

        // =====================================================
        // SETTINGS
        // =====================================================

        BlocProvider<SettingsCubit>(
          create: (_) => SettingsCubit(),
        ),

        // =====================================================
        // PRODUCTS
        // =====================================================

        BlocProvider<ProductCubit>(
          create: (_) => ProductCubit(
            repository: productRepository,
          ),
        ),
      ],
      child: const TechStoreApp(),
    ),
  );
}

// =============================================================
// APP
// =============================================================

class TechStoreApp extends StatelessWidget {
  const TechStoreApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,

          // ===================================================
          // ROUTER
          // ===================================================

          routerConfig: AppRouter.router,

          // ===================================================
          // LANGUAGE
          // ===================================================

          locale: state.locale,

          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],

          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          // ===================================================
          // THEME
          // ===================================================

          themeMode: state.themeMode,

          theme: AppTheme.lightTheme,

          darkTheme: AppTheme.darkTheme,
        );
      },
    );
  }
}