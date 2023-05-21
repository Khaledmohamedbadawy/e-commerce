import 'package:commerce/Screens/home.dart';
import 'package:commerce/Screens/signup.dart';
import 'package:commerce/widgets/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:commerce/servecies/auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/customtextfield.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreenScreen';


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
final GlobalKey<FormState>_globalKey=GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState>_globalKey=GlobalKey<FormState>();


  String?_email;

  String?password ;

  bool loading = false ;

  final _auth =Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.orange[300],
      body:
      Center(
        child: Container(
          margin: EdgeInsets.only(top:height*.08),
          child: ModalProgressHUD(
            inAsyncCall: loading,
            child: Form(
              key: _globalKey,
              child: ListView(
                  children: [
                    logo(),
                    SizedBox(height: height*.1,),
                    Customtextfield(
                        onclick: (value){
                          _email=value;
                        },
                        icon: Icons.email,hint: 'Enter Your Email'),
                    SizedBox(height: height*.025,),
                    Customtextfield(
                        onclick: (value){
                          password=value;
                        },
                        hint: 'Enter Your Password', icon: Icons.lock),
                    SizedBox(height: height*.05,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:60),
                      child: Builder(
                          builder: (context) {
                            return MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
                                color: Colors.black,
                                onPressed: ()async  {
                                  setState(() {
                                    loading=true;
                                  });

                                  if(_globalKey.currentState!.validate()){
                                    _globalKey.currentState!.save();
                                    print(_email);
                                    print(password);
                                    try{
                                      _globalKey.currentState!.save();
                                      final authresult = await  _auth.signup(_email!, password!);
                                      setState(() {
                                        loading=false;
                                      });
                                      Navigator.pushNamed(context, homepage.id);
                                      print(authresult!.user!.uid); }
                                    on FirebaseAuthException catch (e){
                                      print(e.toString());
                                      setState(() {
                                        loading=false;
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
                                    }

                                  }
                                  setState(() {
                                    loading=false;
                                  });


                                  ;
                                },

                                child: Text('Sign Up',style: TextStyle(color: Colors.white,),)

                            );
                          }
                      ),
                    ),
                    SizedBox(height: height*.04,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Dont Hava an Account ?',style: TextStyle(color: Colors.white),),
                        GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context,LoginScreen.id);
                            },
                            child: Text('  Signup'))
                      ],)
                  ]),
            ),
          ),
        ),
      ),

    );
  }
}
