import 'package:tech_store/core/service/productApiService.dart';
import 'package:tech_store/data/models/PruductModel.dart';

class ProductRepository {
  final ProductApiService apiService;

  ProductRepository({
    required this.apiService,
  });

  // =========================================================
  // GET ALL PRODUCTS
  // =========================================================

  Future<List<ProductModel>> getProducts() async {
    final data = await apiService.getProducts();

    return data
        .map(
          (json) => ProductModel.fromJson(json),
        )
        .toList();
  }

  // =========================================================
  // GET PRODUCTS BY CATEGORY
  // =========================================================

  Future<List<ProductModel>> getProductsByCategory(
    String category,
  ) async {
    final data =
        await apiService.getProductsByCategory(
      category,
    );

    return data
        .map(
          (json) => ProductModel.fromJson(json),
        )
        .toList();
  }

  // =========================================================
  // SEARCH PRODUCTS
  // =========================================================

  Future<List<ProductModel>> searchProducts(
    String query,
  ) async {
    final data =
        await apiService.searchProducts(query);

    return data
        .map(
          (json) => ProductModel.fromJson(json),
        )
        .toList();
  }
}