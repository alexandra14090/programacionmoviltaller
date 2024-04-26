import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final double price;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  Product copyWith({
    int? quantity,
  }) {
    return Product(
      id: id,
      name: name,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}

class ProductNotifier extends ChangeNotifier {
  final List<Product> _products = [
    Product(id: 1, name: 'Producto1', price: 20.000),
    Product(id: 2, name: 'Producto2', price: 4.000),
    Product(id: 3, name: 'Producto3', price: 3.000),
    Product(id: 4, name: 'Producto4', price: 4.500),
    Product(id: 5, name: 'Producto5', price: 6.000),
    Product(id: 6, name: 'Producto6', price: 10.000),
    Product(id: 7, name: 'Producto7', price: 1.500),
    Product(id: 8, name: 'Producto8', price: 6.000),
    Product(id: 9, name: 'Producto9', price: 5.000),
    Product(id: 10, name: 'Producto10', price: 300),
  ];

  final List<Product> _cart = [];

  List<Product> get products => _products;
  List<Product> get cart => _cart;

  void addToCart(BuildContext context, Product product) {
    print('Agregando al carrito: ${product.name}');

    final existingProduct = _cart.firstWhere((p) => p.id == product.id, orElse: () => Product(id: -1, name: 'Not Found', price: 0.0, quantity: 0));
    if (existingProduct.id != -1) {
      _cart.add(existingProduct.copyWith(quantity: existingProduct.quantity + 1));
    } else {
      _cart.add(product.copyWith());
    }

    notifyListeners();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushNamed(context, '/cart');
    });
  }

  void removeFromCart(Product product) {
    print('Eliminando del carrito: ${product.name}');

    final cartProduct = _cart.firstWhere((p) => p.id == product.id, orElse: () => Product(id: -1, name: 'Not Found', price: 0.0, quantity: 0));
    if (cartProduct.id != -1) {
      if (cartProduct.quantity > 1) {
        _cart.remove(cartProduct);
        _cart.add(cartProduct.copyWith(quantity: cartProduct.quantity - 1));
      } else {
        _cart.remove(cartProduct);
      }
      notifyListeners();
    } else {
      print('Producto no encontrado en el carrito');
    }
  }

  double get total => _cart.fold(0.0, (total, product) => total + product.price * product.quantity);
}