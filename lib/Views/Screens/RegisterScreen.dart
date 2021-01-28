import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easychat_app/Views/Component/MyTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';



class RegisterScreen extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Future<void> addUser(String email, String password, String username) {

      // var now = new DateTime.now();

      CollectionReference users = FirebaseFirestore.instance.collection('Users');
      return users.add({
        'Email': email,
        'Password': password,
        'Username': username,
      })
      // .then((value) => print("sent"))
          .catchError((error) => print("Failed: $error"));
    }

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: width*.1),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height*.2,),
              Text(
                'Register',
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: height*.04,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: height*.08,),
              Text(
                'Email',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: height*.025,
                    fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: height*.01,),
              MyTextField(hint: "email",controller: emailController,),
              SizedBox(height: height*.02,),
              Text(
                'Username',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: height*.025,
                    fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: height*.01,),
              MyTextField(hint: "username",controller: usernameController,),
              SizedBox(height: height*.02,),
              Text(
                'Password',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: height*.025,
                    fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: height*.02,),
              MyTextField(hint: 'password',controller: passwordController,),
              SizedBox(height: height*.1,),
              GestureDetector(
                onTap: () async {
                  //Close Keyboard
                  FocusScope.of(context).requestFocus(FocusNode());
                  //Check textfields
                  if(emailController.text == ''){
                    Flushbar(
                      title: "Warning",
                      message: "Enter your email",
                      backgroundColor: Colors.teal,
                      boxShadows: [BoxShadow(color: Colors.red[800], offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
                      duration:  Duration(seconds: 2),
                    ).show(context);
                  }
                  else if(passwordController.text == ''){
                    Flushbar(
                      title: "Warning",
                      message: "Enter your password",
                      backgroundColor: Colors.teal,
                      boxShadows: [BoxShadow(color: Colors.red[800], offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
                      duration:  Duration(seconds: 2),
                    ).show(context);
                  }
                  else {
                    //make request
                    var myReturn = await register(emailController.text, passwordController.text);
                    //test response
                    if (myReturn == true){
                      addUser(emailController.text,passwordController.text,usernameController.text);
                      emailController.clear();
                      passwordController.clear();
                      Navigator.pop(context);
                    }
                    else{
                      Flushbar(
                        title: "Warning",
                        message: myReturn.toString(),
                        backgroundColor: Colors.teal,
                        boxShadows: [BoxShadow(color: Colors.red[800], offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
                        duration:  Duration(seconds: 2),
                      ).show(context);
                    }
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: width*.1),
                  width: width*.6,
                  height: height*.08,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(height*.015)
                  ),
                  child: Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: height*.026
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height*.01,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already A User ?',
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Text(
                      ' Login',
                      style: TextStyle(
                          color: Colors.teal
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
