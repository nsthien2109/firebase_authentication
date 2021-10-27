import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/Services/authen_service.dart';
import 'package:firebase_authentication/authentication/authentication.dart';
import 'package:firebase_authentication/pages/Login/login_page.dart';
import 'package:firebase_authentication/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Function toggleScreen;
    final _init = Firebase.initializeApp();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Authentication',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        body: SafeArea(
          child: FutureBuilder(
            future: _init,
            builder: (context, snapshot){
              if(snapshot.hasError){
                return ErrorWidget();
              }else if(snapshot.hasData){
                return  MultiProvider(
                    providers: [
                      ChangeNotifierProvider<AuthService>.value(value: AuthService()),
                      StreamProvider<User?>.value(value: AuthService().user, initialData: null,)
                    ],
                  child: Wrapper(),
                );
              }else{
                return LoadingWidget();
              }
            },
          ),
        )
      ),
    );
  }

  Widget ErrorWidget(){
    return Center(
      child: Column(
        children: const [
          Icon(Icons.error_outline,size: 40,color: Colors.deepOrange,),
          SizedBox(height: 20,),
          Text("Some thing error")
        ],
      ),
    );
  }

  Widget LoadingWidget(){
    return CircularProgressIndicator();
  }
}
