import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future login(String email,String password) async {
  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    print(userCredential.user);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      return false;
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      return false;
    }
  }
}

Future signOut()async{
  await FirebaseAuth.instance.signOut();
}