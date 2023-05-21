import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/Screens/login.dart';
import 'package:commerce/Screens/productinfo.dart';
import 'package:commerce/servecies/store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../servecies/auth.dart';
import '../widgets/constants.dart';
import 'CartScreen.dart';
import 'models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../provider/cartItem.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
class homepage extends StatefulWidget {
  static String id = 'homepage';


  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final _auth = Auth();
  User? _loggedUser;
  int _tabbarindex=0 ;
  int _bottomBarIndex =0;
  final _store =store();
 List<Product> _products =[];
 String? name ;
  String? price ;
  String? deccription ;
  String? location ;
  String? category ;


  @override
  Widget build(BuildContext context) {
    return
      Scaffold(

          bottomNavigationBar:
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width-20,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),

                  ),
                  child:BottomNavigationBar(
                    selectedFontSize: 15,

                    backgroundColor: Colors.orange.shade300,
                    type: BottomNavigationBarType.fixed,
                    unselectedItemColor: Colors.black,
                    currentIndex: _bottomBarIndex,
                    fixedColor: Colors.white,
                    onTap: (value) async {
                      if (value == 0) {
                        Navigator.popAndPushNamed(context, homepage.id);
                      }
                      if (value == 1) {

                        Navigator.popAndPushNamed(context, CartScreen.id);
                      }
                      if (value == 2) {

                        SharedPreferences pref =
                        await SharedPreferences.getInstance();
                        pref.clear();
                        await _auth.signOut();
                        Navigator.popAndPushNamed(context, LoginScreen.id);
                      }
                      setState(() {
                        _bottomBarIndex = value;
                      });
                    },
                    items: [
                      BottomNavigationBarItem(

                          label: ('Home'), icon: Icon(Icons.home)),
                      BottomNavigationBarItem(
                          label: ('My Cart'), icon: Icon(Icons.shopping_cart)),
                      BottomNavigationBarItem(
                          label: ('Sign Out'), icon: Icon(Icons.logout)),
                    ],
                  ) ), ),

          

//
          body:
          Stack(
        children: [
          DefaultTabController(
            animationDuration: Duration(seconds: 1),
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                bottom: TabBar(
                    indicatorColor: Colors.orange[200],
                    onTap: (value) {
                      setState(() {
                        _tabbarindex = value!;

                      });
                    },
                    tabs: [
                      Text(
                        'Jackets',
                        style: TextStyle(
                          color:
                          _tabbarindex == 0 ? Colors.black : Colors.black26,
                          fontSize: _tabbarindex == 0 ? 16 : 13,
                        ),
                      ),
                      Text(
                        'shoes',
                        style: TextStyle(
                          color:
                          _tabbarindex == 1 ? Colors.black : Colors.black26,
                          fontSize: _tabbarindex == 1 ? 16 : 13,
                        ),
                      ),
                      Text(
                        'T-shirts',
                        style: TextStyle(
                          color:
                          _tabbarindex == 2 ? Colors.black : Colors.black26,
                          fontSize: _tabbarindex == 2 ? 16 : 13,
                        ),
                      ),
                      Text(
                        'Trouser',
                        style: TextStyle(
                          color:
                          _tabbarindex == 3 ? Colors.black : Colors.black26,
                          fontSize: _tabbarindex == 3 ? 16 : 13,
                        ),
                      ),
                    ]),
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  jacketview!(),
                  ProductsView!(kshoes!,_products!),
                  ProductsView!(ktshirts!,_products!),
                  ProductsView!(ktrousers!, _products!),

                ],
              ),
            ),
          ),
          Material(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Container(
                height: MediaQuery.of(context).size.height * .1,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discover'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, CartScreen.id);
                          },
                          child:  Icon(Icons.shopping_cart,size: 40,color: Colors.orange.shade300,))

                    ]),
              ),
            ),
          )
        ],
      ));

  }



 Widget jacketview() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadproduct(),
        builder:(context,snapshot) {
          if(snapshot.hasData){
            List<Product> products =[];
            for (var docs in snapshot.data!.docs) {
              var data = docs.data() as Map<String, dynamic>;

                products.add(Product(
                    pid: docs.id,
                    pprice: data[kproductprice],
                    pname: data[kproductname],
                    pcategory: data[kproductcategory],
                    pdescribtion: data[kproductdescription],
                    plocation: data[kproductlocation]));
              }
           _products =[...products];
            products.clear();
            products =getproductbycatedory(kjackets,_products);

            return
              Center(
                child: GridView.builder(
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1,
                        crossAxisCount: 2),
                    itemCount: products.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context,ProductInfo.id,arguments: products[index]);

                        },
                        child:Card(elevation: 20,
                          shadowColor: Colors.black,

                          child:
                        Stack(
                          children: [
                            Positioned.fill(child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.orange.shade300,width: 1)
                                ),

                                child:
                                Image(image: AssetImage(products[index].plocation!),fit: BoxFit.scaleDown,)),),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white38,
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 40,

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

                        ),)
                        ,
                      ),
                    ) )
                ,
              );
          }
          else { return
            Center(child: Text('Loading .....'));
           }

        }    );
  }


  List<Product> getproductbycatedory(String kjackets,List<Product> allproducts) {
    List<Product>products=[];

  try {
      for (var product in allproducts) {
        if (product.pcategory == kjackets) {
          products.add(product);

        }
      }
    } on Error catch (e) {
      print(e);


    }
return products ;
  }

  Widget ProductsView(String? pcategory, List<Product>? allProducts) {
    List<Product> ? products=[];
    products = getproductbycatedory(pcategory!, allProducts!);

    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadproduct(),
        builder:(context,snapshot) {
          if(snapshot.hasData){
            List<Product> products =[];
            for (var docs in snapshot.data!.docs) {
              var data = docs.data() as Map<String, dynamic>;

              products.add(Product(
                  pid: docs.id,
                  pprice: data[kproductprice],
                  pname: data[kproductname],
                  pcategory: data[kproductcategory],
                  pdescribtion: data[kproductdescription],
                  plocation: data[kproductlocation]));
            }
            _products =[...products];
            products.clear();
            products =getproductbycatedory(pcategory,_products);

            return
              Center(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1,
                        crossAxisCount: 2),
                    itemCount: products.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child:
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context,ProductInfo.id,arguments: products[index]);
                        },
                        
                        child: Stack(
                        children: [
                          Positioned.fill(child:Container(
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.orange.shade300,width: 1)
                      ),
                          child:
                          Image(image: AssetImage(products![index]!.plocation!),fit: BoxFit.scaleDown,)),),
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

                      ),)
                      
                    ) )
                ,
              );
          }
          else { return
            Center(child: Text('Loading .....'));
          }

        }    );


  }


  }




