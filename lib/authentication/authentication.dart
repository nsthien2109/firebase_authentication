import 'package:firebase_authentication/pages/Login/login_page.dart';
import 'package:firebase_authentication/pages/Register/register.dart';
import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  bool isToggle = false;

  void ToggleScreen(){
    setState(() {
      isToggle = !isToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(isToggle){
      return RegisterPage(toggleScreen: ToggleScreen);
    }else{
      return LoginPage(toggleScreen: ToggleScreen);
    }
  }
}
