import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tugas_flutter_cart/models/boxes.dart';
import 'package:tugas_flutter_cart/models/products.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Box<Products> localDBBox = Hive.box<Products>(HiveBox.products);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Keranjang"),
        ),
        body: Container(
            child: Column(
          children: [_buildList()],
        )));
  }

  Widget _buildList() {
    var filteredKeyboard = localDBBox.values
        .where((element) => element.title == "Mechanical Keyboard")
        .toList();
    var filteredMouse = localDBBox.values
        .where((element) => element.title == "Logitech Mouse")
        .toList();

    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: localDBBox.listenable(),
        builder: (BuildContext context, Box<dynamic> value, Widget? child) {
          if (value.isEmpty) {
            return Center(
              child: Text("Keranjang Masih Kosong!"),
            );
          }

          return Column(
            children: [
              buildCartCard(
                  "Mechanical Keyboard", "${filteredKeyboard.length}"),
              buildCartCard("Logitech Mouse", "${filteredMouse.length}"),
            ],
          );
        },
      ),
    );
  }

  Card buildCartCard(var title, var amount) {
    return Card(
        elevation: 4.0,
        child: Dismissible(
          background: Container(
            color: Colors.red,
          ),
          key: UniqueKey(),
          onDismissed: (direction) {
            localDBBox.delete(title);
          },
          child: Column(
            children: [
              ListTile(
                title: Text(title, style: TextStyle(fontSize: 16.0)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('Total : ' + amount,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ));
  }
}
