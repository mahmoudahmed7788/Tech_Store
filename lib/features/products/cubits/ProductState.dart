import 'package:tech_store/data/models/PruductModel.dart';

// =========================================================
// BASE STATE
// =========================================================

abstract class ProductState {}

// =========================================================
// INITIAL
// =========================================================

class ProductInitial extends ProductState {}

// =========================================================
// LOADING
// =========================================================

class ProductLoading extends ProductState {}

// =========================================================
// SUCCESS
// =========================================================

class ProductSuccess extends ProductState {
  final List<ProductModel> products;

  ProductSuccess({
    required this.products,
  });
}

// =========================================================
// ERROR
// =========================================================

class ProductError extends ProductState {
  final String message;

  ProductError({
    required this.message,
  });
}