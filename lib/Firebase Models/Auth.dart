import 'package:easychat_app/Controllers/UserProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future login({String email,String password,var context}) async {
  try {
    await auth.signInWithEmailAndPassword(
        email: email,
        password: password
    );

    Provider.of<UserProvider>(context,listen: false).emailSetter(email);

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