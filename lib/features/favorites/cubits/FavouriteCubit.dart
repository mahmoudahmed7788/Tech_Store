import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_store/data/models/PruductModel.dart';

class FavoritesCubit extends Cubit<List<ProductModel>> {
  FavoritesCubit() : super([]);

  void toggleFavorite(ProductModel product) {
    final currentFavorites =
        List<ProductModel>.from(state);

    final index = currentFavorites.indexWhere(
      (item) => item.id == product.id,
    );

    if (index >= 0) {
      currentFavorites.removeAt(index);
    } else {
      currentFavorites.add(product);
    }

    emit(currentFavorites);
  }

  bool isFavorite(ProductModel product) {
    return state.any(
      (item) => item.id == product.id,
    );
  }

  void removeFavorite(ProductModel product) {
    final currentFavorites =
        List<ProductModel>.from(state);

    currentFavorites.removeWhere(
      (item) => item.id == product.id,
    );

    emit(currentFavorites);
  }

  void clearFavorites() {
    emit([]);
  }
}