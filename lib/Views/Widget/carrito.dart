import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF5EB),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Mi Carrito de Compras',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            ShoppingCart.instance.items.isEmpty
                ? Text('Tu carrito está vacío.', style: TextStyle(fontSize: 18))
                : Column(
                    children: ShoppingCart.instance.items.map((item) {
                      return CartItemCard(item: item);
                    }).toList(),
                  ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Simula el proceso de pago
                _simulatePaymentProcess();
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFFF5EB), // Color principal para Miel
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Pagar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _simulatePaymentProcess() {
    // Simula un proceso de pago que toma 3 segundos
    Future.delayed(Duration(seconds: 3), () {
      // Muestra la notificación de pago exitoso
      _showSuccessNotification();

      // Agrega aquí la lógica para ir a la pantalla de confirmación o mensaje de éxito
    });
  }

  void _showSuccessNotification() {
    Fluttertoast.showToast(
      msg: '¡Compra exitosa!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }
}

class CartItemCard extends StatelessWidget {
  final CartItem item;

  CartItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              item.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(item.description, style: TextStyle(fontSize: 14, color: Colors.grey)),
            SizedBox(height: 8),
            Text(
              item.price,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem {
  final String title;
  final String description;
  final String price;
  final String net;
  final String imageUrl;

  CartItem({
    required this.title,
    required this.description,
    required this.price,
    required this.net,
    required this.imageUrl,
  });
}

class ShoppingCart {
  List<CartItem> items = [];

  void addItem(CartItem item) {
    items.add(item);
  }

  void removeItem(CartItem item) {
    items.remove(item);
  }

  double calculateTotal() {
    double total = 0;
    for (var item in items) {
      total += double.parse(item.price.replaceAll('\$', ''));
    }
    return total;
  }

  // Utiliza un patrón singleton para acceder a la instancia del carrito desde cualquier lugar
  static final ShoppingCart instance = ShoppingCart._internal();

  ShoppingCart._internal();
}
