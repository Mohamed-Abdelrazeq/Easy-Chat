import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier{
  String email = '';

  void emailSetter(email){
    this.email = email;
    notifyListeners();
  }
}