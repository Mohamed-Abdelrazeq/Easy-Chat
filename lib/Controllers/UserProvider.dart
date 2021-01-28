import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier{
  String senderEmail = '';
  String receiverEmail = '';

  void senderEmailSetter(email){
    this.senderEmail = email;
    notifyListeners();
  }
  void receiverEmailSetter(email){
    this.receiverEmail = email;
    notifyListeners();
  }
}