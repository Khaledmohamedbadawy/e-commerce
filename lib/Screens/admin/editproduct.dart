

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/Screens/admin/Editoneproduct.dart';
import 'package:flutter/material.dart';
import 'package:commerce/servecies/store.dart';
import 'package:commerce/widgets/constants.dart';

import '../../widgets/cusommeneu.dart';
import '../models/product.dart';
class editproduct extends StatefulWidget {
  static String id = 'editproduct';

  @override
  State<editproduct> createState() => _editproductState();
}

class _editproductState extends State<editproduct> {
  final _store =store();


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadproduct(),
        builder:(context,snapshot) {
          if(snapshot.hasData){
            List<Product> products =[];
            for (var docs in snapshot.data!.docs) {

              var data = docs.data() as Map<String,dynamic>;

              products.add(Product(
                pid: docs.id,

                  pprice: data[kproductprice],
                  pname: data[kproductname],
                  pcategory: data[kproductcategory],
                  pdescribtion: data[kproductdescription],
                  plocation: data[kproductlocation]));
            }
          return
          Center(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.2,
                  crossAxisCount: 2),
                itemCount: products.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTapUp: (details){
                      double dx=details.globalPosition.dx;
                      double dy =details.globalPosition.dy;
                      double dx2 =MediaQuery.of(context).size.width-dx;
                      double dy2 =MediaQuery.of(context).size.height-dy;

                      showMenu(context: context,
                          position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                          items: [
                            MyPopupMenuItem(child: Text('Edit'),onClick: (){

                              Navigator.pushNamed(context, Editoneproduct.id,arguments:products[index].pid );
                            }),
                            MyPopupMenuItem(child: Text('Delete'),onClick: (){
                              print('delete');
                              Navigator.pop(context);
                              _store.deleteproduct(products[index].pid);
                            }),

                          ]
                      );
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(child: Image(image: AssetImage(products[index].plocation!),fit: BoxFit.scaleDown,)),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          color: Colors.white38,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(products[index].pname!,),
                                Text('\$ ${products[index].pprice}')
                              ],
                          ),
                            ),
                        ),
                      )
                      ],

                    ),
                  ),
                ) )
                ,
          );
          }
          else { return
            Center(child: Text('Loading .....'));
          }

        }    ),
    );
  }

}
