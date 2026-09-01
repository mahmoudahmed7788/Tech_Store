import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tech_store/core/constsnts/AppStrings.dart';
import 'package:tech_store/data/models/PruductModel.dart';
import 'package:tech_store/features/favorites/cubits/FavouriteCubit.dart';
import 'package:tech_store/features/home/widgets/FavouriteCard.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  static const Color primaryBlue = Color(0xFF4C5DFF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;

    final secondaryColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.65) ?? Colors.grey;

    return SafeArea(
      child: BlocBuilder<FavoritesCubit, List<ProductModel>>(
        builder: (context, favorites) {
          // =================================================
          // EMPTY
          // =================================================

          if (favorites.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      color: primaryBlue,
                      size: 80,
                    ),

                    const SizedBox(height: 20),

                    Text(
                      AppStrings.get(context, en: 'favorites', ar: 'المفضلة'),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      AppStrings.get(context, en: 'favoriteEmpty', ar: 'القائمة فارغة'),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: secondaryColor, fontSize: 14),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                child: Text(
                  AppStrings.get(context, en: 'favorites', ar: 'المفضلة'),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  itemCount: favorites.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.58,
                  ),
                  itemBuilder: (context, index) {
                    return FavoriteCard(product: favorites[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
