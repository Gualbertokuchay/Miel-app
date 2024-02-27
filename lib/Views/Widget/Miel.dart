import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MielPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Producto'),
      ),
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('Productos').doc('iqvFkQ2CEulUvinI09AQ').get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            if (snapshot.hasError) return Text('Error al cargar los datos');
            var productData = snapshot.data!.data() as Map<String, dynamic>;
            return Card(
              elevation: 4.0,
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.network(productData['imageUrl'], fit: BoxFit.cover),
                    SizedBox(height: 8),
                    Text(
                      productData['title'],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      productData['description'],
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Neto: ${productData['net']} g',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '\$${productData['price']}',
                          style: TextStyle(fontSize: 20, color: Colors.green[700], fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
