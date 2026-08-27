import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_store/data/models/PruductModel.dart';
class CartCubit extends Cubit<List<ProductModel>> {
  CartCubit() : super([]);

  // ============================================================
  // CART
  // ============================================================

  void addToCart(ProductModel product) {
    emit([
      ...state,
      product,
    ]);
  }

  void removeFromCart(ProductModel product) {
    final updatedCart = List<ProductModel>.from(state);

    final index = updatedCart.indexWhere(
      (item) => item.id == product.id,
    );

    if (index != -1) {
      updatedCart.removeAt(index);
    }

    emit(updatedCart);
  }

  bool isInCart(ProductModel product) {
    return state.any(
      (item) => item.id == product.id,
    );
  }

  int getQuantity(ProductModel product) {
    return state.where(
      (item) => item.id == product.id,
    ).length;
  }

  void increaseQuantity(ProductModel product) {
    emit([
      ...state,
      product,
    ]);
  }

  void decreaseQuantity(ProductModel product) {
    final updatedCart = List<ProductModel>.from(state);

    final index = updatedCart.indexWhere(
      (item) => item.id == product.id,
    );

    if (index != -1) {
      updatedCart.removeAt(index);
    }

    emit(updatedCart);
  }

  double getTotal() {
    double total = 0;

    for (final product in state) {
      total += product.price;
    }

    return total;
  }

  void clearCart() {
    emit([]);
  }

  // ============================================================
  // FAVORITES
  // ============================================================

  final List<ProductModel> _favorites = [];

  List<ProductModel> get favorites =>
      List.unmodifiable(_favorites);

  bool isFavorite(ProductModel product) {
    return _favorites.any(
      (item) => item.id == product.id,
    );
  }

  void toggleFavorite(ProductModel product) {
    if (isFavorite(product)) {
      _favorites.removeWhere(
        (item) => item.id == product.id,
      );
    } else {
      _favorites.add(product);
    }

    // Emit نفس الـ state علشان الـ BlocBuilder يعمل rebuild
    emit(List<ProductModel>.from(state));
  }

  void removeFromFavorites(ProductModel product) {
    _favorites.removeWhere(
      (item) => item.id == product.id,
    );

    emit(List<ProductModel>.from(state));
  }
}
