import 'package:flutter/material.dart';
import 'package:miel/Views/Widget/carrito.dart';

class CerapagaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: cerapagaProductsData.length,
        itemBuilder: (context, index) {
          return CerapagaProductCard(index: index);
        },
      ),
    );
  }
}

class CerapagaProductCard extends StatelessWidget {
  final int index;

  CerapagaProductCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final product = cerapagaProductsData[index];
    return Hero(
      tag: 'cerapaga_product_$index',
      child: GestureDetector(
        onTap: () => _navigateToProductDetails(context, product, index),
        child: ProductCard(product: product),
      ),
    );
  }

  void _navigateToProductDetails(BuildContext context, Map<String, String> product, int index) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => FadeTransition(
          opacity: animation,
          child: CerapagaProductDetails(product: product, index: index),
        ),
      ),
    );
  }
}

class CerapagaProductDetails extends StatelessWidget {
  final Map<String, String> product;
  final int index;

  CerapagaProductDetails({required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cerapaga Product Details')),
      body: Center(
        child: ProductDetailsBody(product: product, tag: 'cerapaga_product_$index'),
      ),
    );
  }
}

class ProductDetailsBody extends StatelessWidget {
  final Map<String, String> product;
  final String tag;

  ProductDetailsBody({required this.product, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: tag,
          child: Image.network(product['imageUrl'] ?? '', fit: BoxFit.cover),
        ),
        // The rest of your product details UI
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, String> product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                product['imageUrl'] ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.error, color: Colors.red),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, String>> cerapagaProductsData = [
  {
    'title': 'Cerapaga Product 0',
    'description': 'Description of Cerapaga Product 0',
    'price': '\$10',
    'net': 'Net: 5g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Cerapaga Product 1',
    'description': 'Description of Cerapaga Product 1',
    'price': '\$20',
    'net': 'Net: 10g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Cerapaga Product 2',
    'description': 'Description of Cerapaga Product 2',
    'price': '\$30',
    'net': 'Net: 15g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Cerapaga Product 0',
    'description': 'Description of Cerapaga Product 0',
    'price': '\$10',
    'net': 'Net: 5g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Cerapaga Product 1',
    'description': 'Description of Cerapaga Product 1',
    'price': '\$20',
    'net': 'Net: 10g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Cerapaga Product 2',
    'description': 'Description of Cerapaga Product 2',
    'price': '\$30',
    'net': 'Net: 15g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Cerapaga Product 0',
    'description': 'Description of Cerapaga Product 0',
    'price': '\$10',
    'net': 'Net: 5g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Cerapaga Product 1',
    'description': 'Description of Cerapaga Product 1',
    'price': '\$20',
    'net': 'Net: 10g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Cerapaga Product 2',
    'description': 'Description of Cerapaga Product 2',
    'price': '\$30',
    'net': 'Net: 15g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Cerapaga Product 0',
    'description': 'Description of Cerapaga Product 0',
    'price': '\$10',
    'net': 'Net: 5g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Cerapaga Product 1',
    'description': 'Description of Cerapaga Product 1',
    'price': '\$20',
    'net': 'Net: 10g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Cerapaga Product 2',
    'description': 'Description of Cerapaga Product 2',
    'price': '\$30',
    'net': 'Net: 15g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
];
