import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/pages/Home/home_page.dart';
import 'package:firebase_authentication/pages/Login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if(user != null){
      return HomePage();
    }else{
      return LoginPage();
    }
    return Container();
  }
}
