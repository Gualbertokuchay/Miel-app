import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:miel/Views/Widget/Miel.dart';
import 'package:miel/Views/Widget/cera.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  final List<Map<String, String>> _mielProductsData = [
    {
      'title': 'Miel Product 0',
      'description': 'Description of Miel Product 0',
      'price': '\$10',
      'net': 'Net: 500g',
      'imageUrl': 'https://via.placeholder.com/150',
    },
    // Más productos...
  ];

  final List<Widget> _pages = [
    MielPage(),
    Cerapage()
    // No olvides añadir el widget del carrito de compras si es necesario
  ];

  void _showCart() {
    showModalBottomSheet(
      context: context,
      builder: (context) => CartPage(mielProductsData: _mielProductsData),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCart,
        child: Icon(Icons.shopping_cart),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildAnimatedIcon(
              'assets/miel.svg',
              isSelected: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            SizedBox(width: 48), // El espacio para el FloatingActionButton
            _buildAnimatedIcon(
              'assets/AbejaCera.svg',
              isSelected: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildAnimatedIcon(String asset, {required bool isSelected, required VoidCallback onTap}) {
    return IconButton(
      icon: SvgPicture.asset(
        asset,
        height: 30,
        width: 30,
        color: isSelected ? Colors.black : Colors.grey,
      ),
      onPressed: onTap,
    );
  }
}

class CartPage extends StatefulWidget {
  final List<Map<String, String>> mielProductsData;

  const CartPage({Key? key, required this.mielProductsData}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.mielProductsData.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: widget.mielProductsData[index]['imageUrl']!,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    title: Text(widget.mielProductsData[index]['title']!),
                    subtitle: Text(widget.mielProductsData[index]['description']!),
                    trailing: Text(widget.mielProductsData[index]['price']!),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Aquí la lógica para finalizar la compra
              setState(() {
                widget.mielProductsData.clear();
              });
              Navigator.pop(context); // Cerrar el modal del carrito
            },
            child: Text('Finalizar Compra'),
          ),
        ],
      ),
    );
  }
}
