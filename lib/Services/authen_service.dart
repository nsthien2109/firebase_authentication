import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService with ChangeNotifier{
  bool _isLoading = false;
  late String _errorMessage ;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future register(String email, String pass) async{
    setLoading(true);
    try{
      UserCredential authResult = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);
      User? user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException{
      setMessage("No internet , Connect to internet please");
      setLoading(false);
    }catch (e){
      setMessage(e.toString());
      setLoading(false);
    }
    notifyListeners();
  }

  Future login(String email, String pass) async{
    setLoading(true);
    try{
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
      User? user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException{
      setMessage("No internet , Connect to internet please");
      setLoading(false);
    }catch (e){
      setMessage(e.toString());
      setLoading(false);
    }
    notifyListeners();
  }

  Future logout() async{
    await firebaseAuth.signOut();
  }

  void setLoading(value){
    _isLoading = value;
    notifyListeners();
  }

  void setMessage(message){
    _errorMessage = message;
    notifyListeners();
  }

  Stream<User> get user => firebaseAuth.authStateChanges().map((event) => event!);
}