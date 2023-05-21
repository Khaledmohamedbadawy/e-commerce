import 'package:commerce/Screens/admin/Editoneproduct.dart';
import 'package:commerce/Screens/admin/addproduct.dart';
import 'package:commerce/Screens/admin/adminhome.dart';
import 'package:commerce/Screens/admin/editproduct.dart';
import 'package:commerce/Screens/home.dart';
import 'package:commerce/Screens/signup.dart';
import 'package:commerce/provider/adminMode.dart';
import 'package:commerce/provider/cartItem.dart';
import 'package:commerce/provider/modelHud.dart';
import 'package:commerce/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/CartScreen.dart';
import 'Screens/admin/OrdersScreen.dart';
import 'Screens/admin/order_details.dart';
import 'Screens/login.dart';
import 'Screens/productinfo.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(app());}
class app extends StatelessWidget {

  bool isUserLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
    builder: (context, snapshot) {
    if (!snapshot.hasData) {
    return MaterialApp(
    home: Scaffold(
    body: Center(
    child: Text('Loading....'),
    ),
    ),
    );
    } else {
    isUserLoggedIn = snapshot.data!.getBool(kKeepMeLoggedIn) ?? false;

    return MultiProvider(
        providers: [
        ChangeNotifierProvider<ModelHud>(
        create: (context) => ModelHud(),
    ),
    ChangeNotifierProvider<CartItem>(
    create: (context) => CartItem(),
    ),
    ChangeNotifierProvider<AdminMode>(
    create: (context) => AdminMode(),
    )
    ],
    child:

      MaterialApp(
     initialRoute: isUserLoggedIn ? homepage.id :  LoginScreen.id,
     routes: {
      LoginScreen.id:(context)=>LoginScreen(),
       Signup.id:(context)=>Signup(),
       homepage.id:(context)=>homepage(),
       adminhome.id:(context)=>adminhome(),
       addproduct.id:(context)=>addproduct(),
       editproduct.id :(context)=>editproduct(),
       Editoneproduct.id :(context)=>Editoneproduct(),
       ProductInfo.id :(context)=>ProductInfo(),
       CartScreen.id: (context) => CartScreen(),
       OrderDetails.id: (context) => OrderDetails(),
       OrdersScreen.id: (context) => OrdersScreen(),

        }

    )
      );
    }
    },
    );
  }
}
// khaled
// test
//bra


