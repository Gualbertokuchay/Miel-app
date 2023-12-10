import 'package:flutter/material.dart';
import 'package:miel/Views/Widget/carrito.dart';

class MielPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: mielProductsData.length,
        itemBuilder: (context, index) {
          final mielProductData = mielProductsData[index];
          return Hero(
            tag: 'miel_product_$index',
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: MielProductDetails(
                          title: mielProductData['title'] ?? '',
                          description: mielProductData['description'] ?? '',
                          price: mielProductData['price'] ?? '',
                          net: mielProductData['net'] ?? '',
                          imageTag: 'miel_product_$index',
                        ),
                      );
                    },
                  ),
                );
              },
              child: MielCardImage(
                title: mielProductData['title'] ?? '',
                description: mielProductData['description'] ?? '',
                price: mielProductData['price'] ?? '',
                net: mielProductData['net'] ?? '',
                imageUrl: mielProductData['imageUrl'] ?? '',
              ),
            ),
          );
        },
      ),
    );
  }
}

class MielProductDetails extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String net;
  final String imageTag;

  MielProductDetails({
    required this.title,
    required this.description,
    required this.price,
    required this.net,
    required this.imageTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Miel Product Details'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: imageTag,
              child: Image.network(
                'https://via.placeholder.com/150',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    price,
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(height: 8),
                  Text(
                    net,
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ShoppingCart.instance.addItem(
                        CartItem(
                          title: title,
                          description: description,
                          price: price,
                          net: net,
                          imageUrl: 'https://via.placeholder.com/150',
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShoppingCartPage(),
                        ),
                      );
                    },
                    child: Text('Buy Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MielCardImage extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String net;
  final String imageUrl;

  MielCardImage({
    required this.title,
    required this.description,
    required this.price,
    required this.net,
    required this.imageUrl,
  });

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
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  net,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
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
];
