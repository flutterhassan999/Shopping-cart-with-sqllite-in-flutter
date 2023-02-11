import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_16/db_helper.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';
import 'cart_provider.dart';

class SelectedCartScreen extends StatefulWidget {
  const SelectedCartScreen({super.key});

  @override
  State<SelectedCartScreen> createState() => _SelectedCartScreenState();
}

class _SelectedCartScreenState extends State<SelectedCartScreen> {
  DBHelper? dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart List'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child) => Text(
                    value.getCounter().toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                animationDuration: const Duration(milliseconds: 300),
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FutureBuilder(
                future: cart.getData(),
                builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Image(image: AssetImage('images/empty_cart.jpg')),
                          SizedBox(height: 20,),
                          Text('Empty! Explore Products',style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                        ],
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Image(
                                            height: 100,
                                            width: 100,
                                            image: NetworkImage(snapshot
                                                .data![index].image
                                                .toString()),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      snapshot.data![index]
                                                          .productName
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        dbHelper!.delete(
                                                            snapshot
                                                                .data![index]
                                                                .id!);
                                                        cart.removeCounter();
                                                        cart.removeTotalPrice(
                                                            double.parse(
                                                          snapshot.data![index]
                                                              .productPrice
                                                              .toString(),
                                                        ));
                                                      },
                                                      child: const Icon(
                                                        Icons.delete,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  // ignore: prefer_interpolation_to_compose_strings
                                                  snapshot.data![index].uniTag
                                                          .toString() +
                                                      " " +
                                                      r"$" +
                                                      snapshot.data![index]
                                                          .productPrice
                                                          .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 37,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          color: Colors.teal,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                int quantity =
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity!;
                                                                int price = snapshot
                                                                    .data![
                                                                        index]
                                                                    .initialPrice!;
                                                                quantity++;
                                                                int? newPrice =
                                                                    price *
                                                                        quantity;
                                                                dbHelper!
                                                                    .updateQuantity(
                                                                  Cart(
                                                                    id: snapshot
                                                                        .data![
                                                                            index]
                                                                        .id!,
                                                                    productId: snapshot
                                                                        .data![
                                                                            index]
                                                                        .id!
                                                                        .toString(),
                                                                    productName: snapshot
                                                                        .data![
                                                                            index]
                                                                        .productName!,
                                                                    initialPrice: snapshot
                                                                        .data![
                                                                            index]
                                                                        .initialPrice!,
                                                                    productPrice:
                                                                        newPrice,
                                                                    quantity:
                                                                        quantity,
                                                                    uniTag: snapshot
                                                                        .data![
                                                                            index]
                                                                        .uniTag
                                                                        .toString(),
                                                                    image: snapshot
                                                                        .data![
                                                                            index]
                                                                        .image
                                                                        .toString(),
                                                                  ),
                                                                )
                                                                    .then(
                                                                        (value) {
                                                                  newPrice = 0;
                                                                  quantity = 0;
                                                                  cart.addTotalPrice(double.parse(snapshot
                                                                      .data![
                                                                          index]
                                                                      .initialPrice!
                                                                      .toString()));
                                                                }).onError((error,
                                                                        stackTrace) {
                                                                  print(error
                                                                      .toString());
                                                                });
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .quantity
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                int quantity =
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity!;
                                                                int price = snapshot
                                                                    .data![
                                                                        index]
                                                                    .initialPrice!;
                                                                quantity--;
                                                                int? newPrice =
                                                                    price *
                                                                        quantity;
                                                                if (quantity >
                                                                    0) {
                                                                  dbHelper!
                                                                      .updateQuantity(
                                                                    Cart(
                                                                      id: snapshot
                                                                          .data![
                                                                              index]
                                                                          .id!,
                                                                      productId: snapshot
                                                                          .data![
                                                                              index]
                                                                          .id!
                                                                          .toString(),
                                                                      productName: snapshot
                                                                          .data![
                                                                              index]
                                                                          .productName!,
                                                                      initialPrice: snapshot
                                                                          .data![
                                                                              index]
                                                                          .initialPrice!,
                                                                      productPrice:
                                                                          newPrice,
                                                                      quantity:
                                                                          quantity,
                                                                      uniTag: snapshot
                                                                          .data![
                                                                              index]
                                                                          .uniTag
                                                                          .toString(),
                                                                      image: snapshot
                                                                          .data![
                                                                              index]
                                                                          .image
                                                                          .toString(),
                                                                    ),
                                                                  )
                                                                      .then(
                                                                          (value) {
                                                                    newPrice =
                                                                        0;
                                                                    quantity =
                                                                        0;
                                                                    cart.removeTotalPrice(double.parse(snapshot
                                                                        .data![
                                                                            index]
                                                                        .initialPrice!
                                                                        .toString()));
                                                                  }).onError((error,
                                                                          stackTrace) {
                                                                    print(error
                                                                        .toString());
                                                                  });
                                                                }
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
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
                      );
                    }
                  }
                  return const Text('');
                }),
            Consumer<CartProvider>(builder: (context, value, child) {
              return Visibility(
                visible: value.getTotalPrice().toStringAsFixed(2) == '0.00'
                    ? false
                    : true,
                child: Column(
                  children: [
                    ReusableWidget(
                        title: 'Sub Total',
                        value: r'$' + value.getTotalPrice().toStringAsFixed(2)),
                    const ReusableWidget(
                      title: 'Discount 25%',
                      value: r'$' + '4',
                    ),
                    ReusableWidget(
                        title: 'Total',
                        value: r'$' + value.getTotalPrice().toStringAsFixed(2)),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title;
  final String value;
  const ReusableWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
