import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de compras'),
      ),
      body: Consumer<ProductNotifier>(
        builder: (context, productNotifier, child) {
          if (productNotifier.cart.isEmpty) {
            return const Center(
              child: Text('El carrito está vacío'),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: productNotifier.cart.length,
                  itemBuilder: (context, index) {
                    final product = productNotifier.cart[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text('Precio: \$${product.price.toStringAsFixed(2)} x ${product.quantity}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          productNotifier.removeFromCart(product);
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: \$${productNotifier.total.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Aquí se puede agregar la lógica para procesar la compra
                        print('Procesando compra...');
                      },
                      child: const Text('Proceder a pagar'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}