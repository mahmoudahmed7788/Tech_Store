import 'package:flutter/material.dart';

import 'package:tech_store/data/models/PruductModel.dart';
import 'ProductCard.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductModel> products;

  const ProductGrid({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    final visibleProducts = products.length > 6
        ? products.sublist(0, 6)
        : products;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: visibleProducts.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.58,
        ),
        itemBuilder: (context, index) {
          final product = visibleProducts[index];

          return ProductCard(
            product: product,
          );
        },
      ),
    );
  }
}