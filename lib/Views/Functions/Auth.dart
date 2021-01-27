import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future login(String email,String password) async {
  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    print(userCredential.user); //todo : provide to the app
    return true;
  } on FirebaseAuthException catch (e) {
    print(e);
    if (e.code == 'user-not-found') {
      return 'email';
    } else if (e.code == 'wrong-password') {
      return 'password';
    }
    else{
      return e;
    }
  }
}

Future register(String email,String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.' ;
    }
  } catch (e) {
    print(e);
  }
}

Future signOut()async{
  await FirebaseAuth.instance.signOut();
}