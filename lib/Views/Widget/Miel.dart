import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miel/Views/Widget/carrito.dart';

class MielPage extends StatelessWidget {
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
        itemCount: mielProductsData.length,
        itemBuilder: (context, index) => MielProductCard(index: index),
      ),
    );
  }
}

class MielProductCard extends StatelessWidget {
  final int index;

  const MielProductCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mielProductData = mielProductsData[index];
    return Hero(
      tag: 'miel_product_$index',
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, animation, __) => FadeTransition(
              opacity: animation,
              child: MielProductDetails(
                productData: mielProductData,
                imageTag: 'miel_product_$index',
              ),
            ),
          ),
        ),
        child: MielCardImage(productData: mielProductData),
      ),
    );
  }
}

class MielProductDetails extends StatelessWidget {
  final Map<String, String> productData;
  final String imageTag;

  const MielProductDetails({
    Key? key,
    required this.productData,
    required this.imageTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Miel Product Details')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: imageTag,
              child: Image.network(
                productData['imageUrl'] ?? 'https://via.placeholder.com/150',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ProductDetailsContent(productData: productData),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsContent extends StatelessWidget {
  final Map<String, String> productData;

  const ProductDetailsContent({Key? key, required this.productData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          productData['title'] ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 8),
        Text(
          productData['description'] ?? '',
          style: const TextStyle(color: Colors.grey, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          productData['price'] ?? '',
          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 8),
        Text(
          productData['net'] ?? '',
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
        const SizedBox(height: 16),
        BuyNowButton(title: productData['title'] ?? ''),
      ],
    );
  }
}

class BuyNowButton extends StatelessWidget {
  final String title;

  const BuyNowButton({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add product to cart logic
        Navigator.push(context, MaterialPageRoute(builder: (_) => ShoppingCartPage()));
      },
      child: const Text('Buy Now'),
    );
  }
}

class MielCardImage extends StatelessWidget {
  final Map<String, String> productData;

  const MielCardImage({Key? key, required this.productData}) : super(key: key);

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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                productData['imageUrl'] ?? 'https://via.placeholder.com/150',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Center(
                  child: Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProductInfoText(productData: productData),
          ),
        ],
      ),
    );
  }
}

class ProductInfoText extends StatelessWidget {
  final Map<String, String> productData;

  const ProductInfoText({Key? key, required this.productData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productData['title'] ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          productData['description'] ?? '',
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          productData['price'] ?? '',
          style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          productData['net'] ?? '',
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }
}

final List<Map<String, String>> mielProductsData = [
  {
    'title': 'Miel Product 0',
    'description': 'Description of Miel Product 0',
    'price': '\$10',
    'net': 'Net: 500g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Miel Product 1',
    'description': 'Description of Miel Product 1',
    'price': '\$20',
    'net': 'Net: 1kg',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Miel Product 2',
    'description': 'Description of Miel Product 2',
    'price': '\$30',
    'net': 'Net: 750g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Miel Product 2',
    'description': 'Description of Miel Product 2',
    'price': '\$30',
    'net': 'Net: 750g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Miel Product 2',
    'description': 'Description of Miel Product 2',
    'price': '\$30',
    'net': 'Net: 750g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Miel Product 2',
    'description': 'Description of Miel Product 2',
    'price': '\$30',
    'net': 'Net: 750g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Miel Product 0',
    'description': 'Description of Miel Product 0',
    'price': '\$10',
    'net': 'Net: 500g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Miel Product 1',
    'description': 'Description of Miel Product 1',
    'price': '\$20',
    'net': 'Net: 1kg',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Miel Product 2',
    'description': 'Description of Miel Product 2',
    'price': '\$30',
    'net': 'Net: 750g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Miel Product 2',
    'description': 'Description of Miel Product 2',
    'price': '\$30',
    'net': 'Net: 750g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Miel Product 2',
    'description': 'Description of Miel Product 2',
    'price': '\$30',
    'net': 'Net: 750g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
  {
    'title': 'Miel Product 2',
    'description': 'Description of Miel Product 2',
    'price': '\$30',
    'net': 'Net: 750g',
    'imageUrl': 'https://via.placeholder.com/150',
  },
];
