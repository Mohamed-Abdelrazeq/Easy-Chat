import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> sendMessage(String message, String sender, String receiver) {

  var now = new DateTime.now();

  DocumentReference messages = FirebaseFirestore.instance.collection('Messages').doc('$now');
  return messages.set({
        'Message': message,
        'Receiver': receiver,
        'Sender': sender,
      })
      .then((value) => print("sent"))
      .catchError((error) => print("Failed: $error"));
}
