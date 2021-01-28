import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addUser(String message, String sender, String receiver) {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  return users
      .add({
        'Message': message,
        'Receiver': receiver,
        'Sender': sender,
      })
      .then((value) => print("sent"))
      .catchError((error) => print("Failed: $error"));
}
