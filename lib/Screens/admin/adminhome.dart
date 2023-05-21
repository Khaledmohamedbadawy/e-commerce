import 'package:commerce/Screens/admin/addproduct.dart';
import 'package:commerce/Screens/admin/editproduct.dart';
import 'package:flutter/material.dart';

import 'OrdersScreen.dart';
class adminhome extends StatefulWidget {
  static String id = 'adminhome';

  @override
  State<adminhome> createState() => _adminhomeState();
}

class _adminhomeState extends State<adminhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(onPressed: (){Navigator.pushNamed(context, addproduct.id);},color: Colors.white, child: Text('Add Product')),
            SizedBox(width: 20,),
            MaterialButton(onPressed: (){Navigator.pushNamed(context, editproduct.id);},color: Colors.white, child: Text('Edit Product')),
            SizedBox(width: 20,),
            MaterialButton(onPressed: (){Navigator.pushNamed(context, OrdersScreen.id);},color: Colors.white, child: Text('View Product')),
          ],
        ),
      ),
    );
  }
}
