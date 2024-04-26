import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'inventory_screen.dart';
import 'cart_screen.dart';
import 'product_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventario de productos',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/cart':
            return MaterialPageRoute(builder: (context) => const CartScreen());
          default:
            return MaterialPageRoute(builder: (context) => const InventoryScreen());
        }
      },
      initialRoute: '/',
    );
  }
}