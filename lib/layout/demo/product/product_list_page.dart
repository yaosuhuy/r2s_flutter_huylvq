import 'package:flutter/material.dart';
import 'package:my_app/layout/demo/product.dart';

void main() {
  runApp(ProductListPage());
}

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _ProductList(),
    );
  }
}

class _ProductList extends StatelessWidget {
  const _ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final products = _getAllProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: Image.network(product.imagePath),
            title: Text(product.title),
            subtitle: Text("${product.description} - ${product.price}"),
          );
        },
      ),
    );
  }
}

/*
Row _buildRow(String imagePath, String title, String description, num price) {
  return Row(
    children: [
      Image.network(
        imagePath,
        width: 100,
        height: 100,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Text(description),
          Text(price.toString()),
        ],
      )
    ],
  );
}
*/
List<Product> _getAllProducts() {
  return [
    Product(
        imagePath:
            "https://cdn.viettelstore.vn/Images/Product/ProductImage/1398702966.jpeg",
        title: "iPhone 16",
        description: "New iPhone",
        price: 900)
  ];
}
