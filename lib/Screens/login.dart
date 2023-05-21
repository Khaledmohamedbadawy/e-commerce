import 'package:commerce/Screens/admin/adminhome.dart';
import 'package:commerce/Screens/home.dart';
import 'package:commerce/Screens/signup.dart';
import 'package:commerce/widgets/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:commerce/servecies/auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/constants.dart';
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
  Color? admin ;
  Color? user ;
  bool isadmin=false ;
  final adminpaswword = 'admin1234';
  bool keepMeLoggedIn = false;
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
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          Theme(
                            data: ThemeData(unselectedWidgetColor: Colors.white,selectedRowColor: Colors.white),
                            child: Checkbox(
                              checkColor: Colors.white,
                              hoverColor: Colors.white10,
                              activeColor: Colors.orange.shade300,
                              value: keepMeLoggedIn,
                              onChanged: (value) {
                                setState(() {
                                  keepMeLoggedIn = value!;
                                });
                              },
                            ),
                          ),
                          Text(
                            'Remmeber Me ',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
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
                                  if (keepMeLoggedIn == true) {
                                    keepUserLoggedIn();
                                  }

                                  setState(() {
                                    loading=true;
                                  });

                                  if(_globalKey.currentState!.validate()){
                                    _globalKey.currentState!.save();
                                    print(_email);
                                    print(password);
                                    if (isadmin==true){
                                      if (password == adminpaswword){
                                        try{
                                          _globalKey.currentState!.save();
                                          final authresult = await  _auth.signin(_email!, password!);
                                          setState(() {
                                            loading=false;
                                          });
                                          Navigator.pushNamed(context, adminhome.id);
                                          print(authresult!.user!.uid); }
                                        on FirebaseAuthException catch (e){
                                          print(e.toString());
                                          setState(() {
                                            loading=false;
                                          });
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
                                        }
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something Went Wrong')));
                                      }


                                    }
                                    if (isadmin==false){
                                      try{
                                        _globalKey.currentState!.save();
                                        final authresult = await  _auth.signin(_email!, password!);
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


                                  }
                                  setState(() {
                                    loading=false;
                                  });
     ;
                                },

                                child: Text('Log In',style: TextStyle(color: Colors.white,),)

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
                              Navigator.pushNamed(context,Signup.id);
                            },
                            child: Text('  Signup'))
                      ],),
                    Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        GestureDetector(

                            child: Text('I\'m Admin',style: TextStyle(color: admin),)
                          ,onTap: (){
                          setState(() {
                            admin =Colors.orange.shade300;
                            user =Colors.white;
                            isadmin =true;
                          });

                        },
                        ),
                        GestureDetector
                          (child: Text('I\'m user',style: TextStyle(color: user),)
                        ,onTap: (){
                            setState(() {
                              user =Colors.orange.shade300;
                              admin =Colors.white;
                              isadmin =false;
                            });

                          },
                        ),

                      ],),
                    )
                  ]),
            ),
          ),
        ),
      ),

    );
  }

  void keepUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
  }
}
