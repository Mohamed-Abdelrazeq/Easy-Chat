import 'package:easychat_app/Controllers/ChatProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future login({String email, String password, var context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Provider.of<ChatProvider>(context, listen: false).senderEmailSetter(email);

      return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'user-not-found') {
        return 'email';
      } else if (e.code == 'wrong-password') {
        return 'password';
      } else {
        return e;
      }
    }
  }

  void submissionFunction(var context) async {
    //Close Keyboard
    FocusScope.of(context).requestFocus(FocusNode());
    //Check textfields
    if (emailController.text == '') {
      Flushbar(
        title: "Warning",
        message: "Enter your email",
        backgroundColor: Colors.teal,
        boxShadows: [
          BoxShadow(
            color: Colors.red[800],
            offset: Offset(0.0, 2.0),
            blurRadius: 3.0,
          )
        ],
        duration: Duration(seconds: 2),
      ).show(context);
    } else if (passwordController.text == '') {
      Flushbar(
        title: "Warning",
        message: "Enter your password",
        backgroundColor: Colors.teal,
        boxShadows: [
          BoxShadow(
            color: Colors.red[800],
            offset: Offset(0.0, 2.0),
            blurRadius: 3.0,
          )
        ],
        duration: Duration(seconds: 2),
      ).show(context);
    } else {
      //make request
      var myReturn = await login(
          email: emailController.text,
          password: passwordController.text,
          context: context);
      //test response
      if (myReturn == true) {
        emailController.clear();
        passwordController.clear();
        Navigator.pushNamed(context, '/ChatSelectionScreen');
      } else if (myReturn == 'password') {
        Flushbar(
          title: "Warning",
          message: "Your password is not correct",
          backgroundColor: Colors.teal,
          boxShadows: [
            BoxShadow(
              color: Colors.red[800],
              offset: Offset(0.0, 2.0),
              blurRadius: 3.0,
            )
          ],
          duration: Duration(seconds: 2),
        ).show(context);
      } else if (myReturn == 'email') {
        Flushbar(
          title: "Warning",
          message: "Your email in not correct",
          backgroundColor: Colors.teal,
          boxShadows: [
            BoxShadow(
              color: Colors.red[800],
              offset: Offset(0.0, 2.0),
              blurRadius: 3.0,
            )
          ],
          duration: Duration(seconds: 2),
        ).show(context);
      } else {
        Flushbar(
          title: "Warning",
          message: "Invalid email and password",
          backgroundColor: Colors.teal,
          boxShadows: [
            BoxShadow(
              color: Colors.red[800],
              offset: Offset(0.0, 2.0),
              blurRadius: 3.0,
            )
          ],
          duration: Duration(seconds: 2),
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: width * .1),
          child: ListView(
            children: [
              SizedBox(
                height: height * .2,
              ),
              Text(
                'Login',
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: height * .04,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * .08,
              ),
              Text(
                'Email',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: height * .025,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: height * .01,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'email',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 1.0),
                  ),
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              Text(
                'Password',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: height * .025,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: height * .02,
              ),
              TextField(
                controller: passwordController,
                onSubmitted: (_) {
                  submissionFunction(context);
                },
                decoration: InputDecoration(
                  hintText: 'password',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 1.0),
                  ),
                ),
              ),
              SizedBox(
                height: height * .1,
              ),
              GestureDetector(
                onTap: () {
                  submissionFunction(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: width * .1),
                  width: width * .6,
                  height: height * .08,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(height * .015)),
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: height * .026),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not A User ?',
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/Register');
                    },
                    child: Text(
                      ' Register',
                      style: TextStyle(color: Colors.teal),
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
