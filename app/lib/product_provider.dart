import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product.dart';

class ProductNotifier extends ChangeNotifier {
  final List<Product> _products = [
    Product(id: 1, name: 'Producto 1', price: 10.99),
    Product(id: 2, name: 'Producto 2', price: 15.50),
    // Falta agregar más productos aquí minimo son 10
  ];

  List<Product> get products => _products;

  void addToCart(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _products.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }

  double get total => _products.fold(0.0, (total, product) => total + product.price * product.quantity);
}

final productProvider = ChangeNotifierProvider<ProductNotifier>(
  create: (context) => ProductNotifier(),
);