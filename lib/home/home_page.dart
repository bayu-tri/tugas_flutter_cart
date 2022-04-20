import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tugas_flutter_cart/Cart/cart_page.dart';
import 'package:tugas_flutter_cart/models/products.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box<Products> localDBBox = Hive.box<Products>("Products");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Produk'),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              buildCard(
                  'Mechanical Keyboard',
                  240000,
                  'https://images.unsplash.com/photo-1595044426077-d36d9236d54a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                  context),
              buildCard(
                  'Logitech Mouse',
                  99000,
                  'https://images.unsplash.com/photo-1563297007-0686b7003af7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=917&q=80',
                  context),
            ],
          )),
    );
  }

  Card buildCard(var title, int price, var imageLink, BuildContext context) {
    var cardImage = NetworkImage(imageLink);

    return Card(
        elevation: 4.0,
        child: InkWell(
          child: Column(
            children: [
              Container(
                height: 300.0,
                child: Ink.image(
                  image: cardImage,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                title: Text('Rp.' + price.toString(),
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(title, style: TextStyle(fontSize: 16.0)),
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              localDBBox.add(Products(title: title, price: price, total: 1));
              return CartPage();
            }));
          },
        ));
  }
}
