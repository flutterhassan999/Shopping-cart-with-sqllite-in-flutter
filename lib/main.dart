import 'package:flutter/material.dart';
import 'package:flutter_application_16/cart_provider.dart';
import 'package:provider/provider.dart';
import 'product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Groceries App',
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          home: const ProductList(),
        );
      }),
    );
  }
}
