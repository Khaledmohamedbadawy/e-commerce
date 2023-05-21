
import 'dart:io';

import 'package:commerce/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:commerce/Screens/models/product.dart';
import 'package:commerce/widgets/customtextfield.dart';
import 'package:commerce/servecies/store.dart';
class Editoneproduct extends StatefulWidget {
  static String id = 'Editoneproduct';
  @override
  State<Editoneproduct> createState() => _EditoneproductState();
}

class _EditoneproductState extends State<Editoneproduct> {
  String? _name ;
  String? _price ;
  String? _describtion ;
  String?_category ;
  String? _imagelocatoion;
  final GlobalKey<FormState>_globalKey=GlobalKey<FormState>();
  final _store = store();
  @override
  Widget build(BuildContext context) {

    String? ss=ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(

      backgroundColor: Colors.green[200],
      body: Form(
        key: _globalKey,
        child: ListView(children: [
          SizedBox(height: MediaQuery.of(context).size.height*.2,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Customtextfield(onclick: (value) {_name=value;},
                hint: 'Product Name',
              ),
              SizedBox(height: 15,),
              Customtextfield(onclick: (value){_price=value;},
                hint: 'Product Price', ),
              SizedBox(height: 15,),
              Customtextfield(onclick: (value){_describtion=value;},
                hint: 'Product Describtion', ),
              SizedBox(height: 15,),
              Customtextfield(onclick: (value){_category=value;},
                hint: 'Product Category', ),
              SizedBox(height: 15,),
              Customtextfield(onclick: (value){_imagelocatoion=value;},
                hint: 'Product Locatin', ),
              SizedBox(height: 25,),
              MaterialButton(color:Colors.white,
                  onPressed: (){
                setState(() {
                  if(_globalKey.currentState!.validate()){
                    _globalKey.currentState!.save();
                    _store.editproduct(({
                      kproductname: _name,
                      kproductprice: _price,
                      kproductlocation: _imagelocatoion,
                      kproductcategory: _category,
                      kproductdescription: _describtion
                    }
                    ),ss);


                  }
                });

                  },
                  child: Text('change Product'))



            ],
          ),
        ],)
      ),

    );
  }
}
