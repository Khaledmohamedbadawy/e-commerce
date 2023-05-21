import 'package:flutter/material.dart';
class logo extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Column(children: [

      Image(image: AssetImage('images/buy.png'),),
      Text('Buy it',style: TextStyle(fontFamily:'Pacifico',fontSize: 40),),
    ],);
  }
}