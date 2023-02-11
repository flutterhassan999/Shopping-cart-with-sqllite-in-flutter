import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_application_16/cart_model.dart';
import 'package:flutter_application_16/db_helper.dart';
import 'package:flutter_application_16/selected_cart_screen.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  DBHelper? dbHelper = DBHelper();
  List<String> productName = [
    'Mango',
    'Orange',
    'Grapes',
    'Banana',
    'Chery',
    'Peach',
    'Mixed Fruit Basket',
  ];
  List<String> productUnit = [
    'KG',
    'Dozen',
    'KG',
    'Dozen',
    'KG',
    'KG',
    'KG',
  ];
  List<int> productPrice = [10, 20, 30, 40, 50, 60, 70];
  List<String> productImage = [
    'https://www.shutterstock.com/image-vector/fresh-mango-slice-leaves-vector-600w-1987479101.jpg',
    'https://www.shutterstock.com/image-vector/vector-set-fresh-ripe-oranges-600w-84096874.jpg',
    'https://www.shutterstock.com/shutterstock/photos/1728930151/display_1500/stock-vector-different-wine-grapes-green-grapes-black-and-red-pink-muscatel-grape-banches-d-vector-icon-set-1728930151.jpg',
    'https://www.shutterstock.com/image-vector/banana-ripe-yellow-set-tropical-600w-1342518854.jpg',
    'https://www.shutterstock.com/image-vector/cheries-vector-illustrationgradient-mesh-600w-1757319677.jpg',
    'https://www.shutterstock.com/image-vector/ripe-peaches-whole-slice-fully-600w-371390959.jpg',
    'https://www.shutterstock.com/image-vector/fresh-fruit-basket-apple-lemon-600w-646850635.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groceries List'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const SelectedCartScreen()));
              },
              child: Center(
                child: Badge(
                  badgeContent: Consumer<CartProvider>(
                    builder: (context, value, child) => Text(
                      value.getCounter().toString(),
                      style:const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  child:const Icon(Icons.shopping_cart),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: productName.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding:const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image(
                                height: 100,
                                width: 100,
                                image: NetworkImage(
                                    productImage[index].toString()),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productName[index].toString(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      // ignore: prefer_interpolation_to_compose_strings
                                      productUnit[index].toString() +
                                          " " +
                                          r"$" +
                                          productPrice[index].toString(),
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          dbHelper!
                                              .insert(Cart(
                                            id: index,
                                            productId: index.toString(),
                                            productName:
                                                productName[index].toString(),
                                            initialPrice: productPrice[index],
                                            productPrice: productPrice[index],
                                            quantity: 1,
                                            uniTag:
                                                productUnit[index].toString(),
                                            image:
                                                productImage[index].toString(),
                                          ))
                                              .then((value) {
                                            print('Product added Successfully');
                                            cart.addTotalPrice(double.parse(
                                                productPrice[index]
                                                    .toString()));
                                            cart.addCounter();
                                          }).onError((error, stackTrace) {
                                            // ignore: avoid_print
                                            print(error.toString());
                                          });
                                        },
                                        child: Container(
                                          height: 37,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.teal,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: const Center(
                                              child: Text('Add to cart',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

