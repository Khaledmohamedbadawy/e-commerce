import 'package:commerce/servecies/store.dart';

import '../../servecies/sto.dart';
import '../../servecies/store.dart';
import '../../widgets/constants.dart';
import 'package:commerce/Screens/models/order.dart' ;

import 'package:commerce/servecies/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/servecies/store.dart';
import 'package:commerce/servecies/store.dart';
import 'package:flutter/material.dart';

import '../../servecies/store.dart';
import '../../servecies/store.dart';
import '../models/product.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  store _store = store();
  sto _sto = sto();
  @override
  Widget build(BuildContext context) {
    String documentId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadOrderDetails(documentId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var doc in snapshot.data!.docs) {
                products.add(Product(
                  pname: doc[kproductname],
                  pquantity: doc[kProductQuantity],
                  pcategory: doc[kproductcategory],
                ));
              }

              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .2,
                          color: Colors.amber,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('product name : ${products[index].pname}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Quantity : ${products[index].pquantity}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'product Category : ${products[index].pcategory}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      itemCount: products.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: Colors.redAccent,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.greenAccent
                              ),
                              onPressed: () {},
                              child: Text('Confirm Order'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: Colors.red,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                _sto.deleteoredr(documentId);

                              },
                              child: Text('Delete Order'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text('Loading Order Details'),
              );
            }
          }),
    );
  }
}
