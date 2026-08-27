import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_store/data/models/PruductModel.dart';
import 'package:tech_store/data/reposatory/ProductReposatory.dart';

import 'ProductState.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit({
    required this.repository,
  }) : super(ProductInitial());

  // =========================================================
  // GET ALL PRODUCTS
  // =========================================================

  Future<void> getProducts() async {
    await _execute(
      request: repository.getProducts,
    );
  }

  // =========================================================
  // GET PRODUCTS BY CATEGORY
  // =========================================================

  Future<void> getProductsByCategory(
    String category,
  ) async {
    final cleanCategory = category.trim();

    if (cleanCategory.isEmpty ||
        cleanCategory.toLowerCase() == 'all') {
      await getProducts();
      return;
    }

    await _execute(
      request: () {
        return repository.getProductsByCategory(
          cleanCategory,
        );
      },
    );
  }

  // =========================================================
  // SEARCH PRODUCTS
  // =========================================================

  Future<void> searchProducts(
    String query,
  ) async {
    final cleanQuery = query.trim();

    if (cleanQuery.isEmpty) {
      await getProducts();
      return;
    }

    await _execute(
      request: () {
        return repository.searchProducts(
          cleanQuery,
        );
      },
    );
  }

  // =========================================================
  // EXECUTE REQUEST
  // =========================================================

  Future<void> _execute({
    required Future<List<ProductModel>> Function()
        request,
  }) async {
    emit(ProductLoading());

    try {
      final products = await request();

      emit(
        ProductSuccess(
          products: products,
        ),
      );
    } catch (e) {
      emit(
        ProductError(
          message: _cleanErrorMessage(e),
        ),
      );
    }
  }

  // =========================================================
  // CLEAN ERROR
  // =========================================================

  String _cleanErrorMessage(Object error) {
    final message = error.toString();

    if (message.startsWith('Exception: ')) {
      return message.substring(
        'Exception: '.length,
      );
    }

    return message;
  }
}