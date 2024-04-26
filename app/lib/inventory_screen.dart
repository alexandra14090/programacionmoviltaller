import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_provider.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.lightBlue[100], 
        ),
        title: const Text(
          'Inventario de productos',
          style: TextStyle(color: Color.fromARGB(255, 19, 19, 19)), 
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ProductNotifier(),
        child: Consumer<ProductNotifier>(
          builder: (context, productNotifier, child) {
            return ListView.builder(
              itemCount: productNotifier.products.length,
              itemBuilder: (context, index) {
                final product = productNotifier.products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Precio: \$${product.price.toStringAsFixed(2)}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      productNotifier.addToCart(product);
                    },
                    child: const Text('Agregar al carrito'),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        label: const Text('Ver carrito'),
      ),
    );
  }
}