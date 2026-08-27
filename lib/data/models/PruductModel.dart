class ProductModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String thumbnail;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.thumbnail,
    required this.images,
  });

  // =========================================================
  // FROM JSON
  // =========================================================

  factory ProductModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProductModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(
                '${json['id']}',
              ) ??
              0,

      title: json['title']?.toString() ?? '',

      description:
          json['description']?.toString() ?? '',

      category:
          json['category']?.toString() ?? '',

      price: _toDouble(
        json['price'],
      ),

      discountPercentage: _toDouble(
        json['discountPercentage'],
      ),

      rating: _toDouble(
        json['rating'],
      ),

      stock: json['stock'] is int
          ? json['stock']
          : int.tryParse(
                '${json['stock']}',
              ) ??
              0,

      brand: json['brand']?.toString() ?? '',

      thumbnail:
          json['thumbnail']?.toString() ?? '',

      images: _parseImages(
        json['images'],
      ),
    );
  }

  // =========================================================
  // DOUBLE PARSER
  // =========================================================

  static double _toDouble(
    dynamic value,
  ) {
    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(
          value?.toString() ?? '',
        ) ??
        0.0;
  }

  // =========================================================
  // IMAGES PARSER
  // =========================================================

  static List<String> _parseImages(
    dynamic value,
  ) {
    if (value is! List) {
      return [];
    }

    return value
        .map(
          (image) => image.toString(),
        )
        .where(
          (image) => image.isNotEmpty,
        )
        .toList();
  }
}