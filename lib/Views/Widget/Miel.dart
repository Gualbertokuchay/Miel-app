import 'package:flutter/material.dart';

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

class MielProductDetails extends StatefulWidget {
  final Map<String, String> productData;
  final String imageTag;

  const MielProductDetails({
    Key? key,
    required this.productData,
    required this.imageTag,
  }) : super(key: key);

  @override
  _MielProductDetailsState createState() => _MielProductDetailsState();
}

class _MielProductDetailsState extends State<MielProductDetails> {
  int quantity = 1;
  List<Map<String, String>> cartItems = [];

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void addToCart() {
    setState(() {
      cartItems.add(widget.productData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productData['title'] ?? ''),
        actions: <Widget>[
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                if (cartItems.isNotEmpty)
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: Text(
                        cartItems.length.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(cartItems[index]['title'] ?? ''),
                        trailing: Text(cartItems[index]['price'] ?? ''),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 300,
              child: Hero(
                tag: widget.imageTag,
                child: Image.network(
                  widget.productData['imageUrl'] ?? 'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.productData['title'] ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.productData['description'] ?? '',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: decrementQuantity,
                      ),
                      Text('$quantity'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: incrementQuantity,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: addToCart,
                      child: Text('Add to Cart'),
                    ),
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
  // Agrega más productos aquí si es necesario
];


