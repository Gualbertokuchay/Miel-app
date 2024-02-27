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
      appBar: _buildAppBar(),
      backgroundColor: Color(0xFFFFF5EB),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFFFFF5EB),
      centerTitle: true,
      title: Text("Mi Carrito de Compras", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(27.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildCartItems(),
          SizedBox(height: 20),
          _buildTotalPrice(),
          SizedBox(height: 20),
          _buildPayButton(),
        ],
      ),
    );
  }

  Widget _buildCartItems() {
    var items = ShoppingCart.instance.items;
    return Expanded(
      child: items.isEmpty
          ? Center(child: Text('Tu carrito está vacío.', style: TextStyle(fontSize: 14.4)))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => CartItemCard(item: items[index]),
            ),
    );
  }

  Widget _buildTotalPrice() {
    return Text(
      'Total: \$${ShoppingCart.instance.calculateTotal().toStringAsFixed(2)}',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPayButton() {
    return ElevatedButton(
      onPressed: _simulatePaymentProcess,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
      child: Text('Pagar', style: TextStyle(fontSize: 20)),
    );
  }

  void _simulatePaymentProcess() {
    Future.delayed(Duration(seconds: 3), () {
      _showSuccessNotification();
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
            Text(item.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            Text(item.description, style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${item.price}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                IconButton(
                  onPressed: () => ShoppingCart.instance.removeItem(item),
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              ],
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

  static final ShoppingCart instance = ShoppingCart._internal();

  ShoppingCart._internal();
}
