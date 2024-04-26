import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.lightBlue[100], 
        ),
        title: const Text(
          'Carrito de compras',
          style: TextStyle(
            color: Colors.black, 
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ProductNotifier(),
        child: Consumer<ProductNotifier>(
          builder: (context, productNotifier, child) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: productNotifier.products.length,
                    itemBuilder: (context, index) {
                      final product = productNotifier.products[index];
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text('Precio: \$${product.price.toStringAsFixed(2)}'),
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
                          // Aquí podemos agregar la lógica para procesar la compra, lo único que hace esta parte es mostrar en la consola de depuración cuando el usuario le da en proceder a pagar muestra el mensaje procesando compra, no es necesario solo si lo quiere poner  
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
      ),
    );
  }
}