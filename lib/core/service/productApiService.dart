import 'package:dio/dio.dart';

class ProductApiService {
  final Dio dio;

  ProductApiService({required this.dio});

  static const String baseUrl = 'https://dummyjson.com';

  // =========================================================
  // GET ALL PRODUCTS
  // =========================================================

  Future<List<Map<String, dynamic>>> getProducts() async {
    try {
      final response = await dio.get(
        '$baseUrl/products',
        queryParameters: {'limit': 6},
      );

      final data = response.data;

      if (data is! Map<String, dynamic>) {
        throw Exception('Invalid products response.');
      }

      final products = data['products'];

      if (products is! List) {
        return [];
      }

      return List<Map<String, dynamic>>.from(products);
    } on DioException catch (e) {
      throw Exception(_getDioErrorMessage(e, 'Failed to load products'));
    } catch (e) {
      throw Exception('Failed to load products');
    }
  }

  // =========================================================
  // GET PRODUCTS BY CATEGORY
  // =========================================================

  Future<List<Map<String, dynamic>>> getProductsByCategory(
    String category,
  ) async {
    try {
      final response = await dio.get(
        '$baseUrl/products/category/$category',
        queryParameters: {'limit': 6},
      );

      final data = response.data;

      if (data is! Map<String, dynamic>) {
        throw Exception('Invalid category response.');
      }

      final products = data['products'];

      if (products is! List) {
        return [];
      }

      return List<Map<String, dynamic>>.from(products);
    } on DioException catch (e) {
      throw Exception(
        _getDioErrorMessage(e, 'Failed to load category products'),
      );
    } catch (e) {
      throw Exception('Failed to load category products');
    }
  }

  // =========================================================
  // SEARCH PRODUCTS
  // =========================================================

  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    try {
      final response = await dio.get(
        '$baseUrl/products/search',
        queryParameters: {'q': query, 'limit': 6},
      );

      final data = response.data;

      if (data is! Map<String, dynamic>) {
        throw Exception('Invalid search response.');
      }

      final products = data['products'];

      if (products is! List) {
        return [];
      }

      return List<Map<String, dynamic>>.from(products);
    } on DioException catch (e) {
      throw Exception(_getDioErrorMessage(e, 'Failed to search products'));
    } catch (e) {
      throw Exception('Failed to search products');
    }
  }

  // =========================================================
  // GET CATEGORIES
  // =========================================================

  Future<List<String>> getCategories() async {
    try {
      final response = await dio.get('$baseUrl/products/category-list');

      final data = response.data;

      if (data is! List) {
        return [];
      }

      return List<String>.from(data.map((category) => category.toString()));
    } on DioException catch (e) {
      throw Exception(_getDioErrorMessage(e, 'Failed to load categories'));
    } catch (e) {
      throw Exception('Failed to load categories');
    }
  }

  // =========================================================
  // DIO ERROR
  // =========================================================

  String _getDioErrorMessage(DioException error, String fallback) {
    if (error.message != null && error.message!.trim().isNotEmpty) {
      return error.message!;
    }

    return fallback;
  }
}
