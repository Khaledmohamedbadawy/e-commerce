

import 'package:flutter/material.dart';
class Customtextfield extends StatelessWidget {
  final String? hint ;
  final IconData? icon ;
  final void Function(String?) onclick;
  String? _errormessage(String str){
    switch(hint){
      case 'Enter Your Name':return 'Name Is Empty' ;
      case 'Enter Your Email':return 'Email Is Empty' ;
      case 'Enter Your Password':return 'Password Is Empty' ;

    }
  }
  Customtextfield({ required this.onclick,@required this.hint ,@required this.icon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        onSaved: onclick,
        obscureText: hint=='Enter Your Password' ? true : false ,
        validator: (value){
          if(value!.isEmpty){
            return _errormessage(hint!);
          }
        },
        cursorColor: Colors.teal,
        decoration:
        InputDecoration(
          hintText: hint,

          prefixIcon:Icon(
              color: Colors.orange,
              icon) ,

          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)
          ),
          fillColor: Colors.white70,
          enabled: true,
          filled: true,

        ),),
    );
  }
}