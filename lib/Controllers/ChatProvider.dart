import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier{
  String senderEmail = '';
  String receiverEmail = '';
  String receiverUsername = '';

  void senderEmailSetter(email){
    this.senderEmail = email;
    notifyListeners();
  }
  void receiverEmailSetter(email){
    this.receiverEmail = email;
    notifyListeners();
  }
  void receiverUsernameSetter(email){
    this.receiverUsername = email;
    notifyListeners();
  }

  List<String> sort(){
    List<String> talkers = [receiverEmail,senderEmail];
    talkers.sort();
    print(talkers);
    return talkers;
  }

}