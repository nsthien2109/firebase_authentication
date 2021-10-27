import 'package:firebase_authentication/Services/authen_service.dart';
import 'package:firebase_authentication/pages/Login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _Logined = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("Home" , style: TextStyle(fontSize: 25  , color: Colors.black),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () async{
            try{
             await _Logined.logout();
            }catch (e){

            }
          }, icon: const Icon(Icons.logout ,color: Colors.black,)),
        ],
      ),
    );
  }
}
