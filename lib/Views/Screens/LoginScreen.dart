import 'package:easychat_app/Views/Component/MyTextField.dart';
import 'package:easychat_app/Views/Functions/Auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'ChatScreen.dart';

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                'Login',
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
              MyTextField(hint: "Email",controller: email,),
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
              MyTextField(hint: 'Password',controller: password,),
              SizedBox(height: height*.1,),
              GestureDetector(
                onTap: () async {
                  //Close Keyboard
                  FocusScope.of(context).requestFocus(FocusNode());
                  //Check textfields
                  if(email.text == ''){
                    Flushbar(
                      title: "Warning",
                      message: "Enter your email",
                      backgroundColor: Colors.teal,
                      boxShadows: [BoxShadow(color: Colors.red[800], offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
                      duration:  Duration(seconds: 2),
                    ).show(context);
                  }
                  else if(password.text == ''){
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
                    var myReturn = await login(email.text, password.text);
                    //test response
                    if (myReturn == true){
                      email.clear();
                      password.clear();
                      Navigator.pushNamed(context, '/Test');
                    }
                    else if (myReturn == 'password') {
                      Flushbar(
                        title: "Warning",
                        message: "Your password is not correct",
                        backgroundColor: Colors.teal,
                        boxShadows: [BoxShadow(color: Colors.red[800], offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
                        duration:  Duration(seconds: 2),
                      ).show(context);
                    }
                    else if (myReturn == 'email'){
                      Flushbar(
                        title: "Warning",
                        message: "Your email in not correct",
                        backgroundColor: Colors.teal,
                        boxShadows: [BoxShadow(color: Colors.red[800], offset: Offset(0.0, 2.0), blurRadius: 3.0,)],
                        duration:  Duration(seconds: 2),
                      ).show(context);
                    }
                    else{
                      Flushbar(
                        title: "Warning",
                        message: "Invalid email and password",
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
                      'Login',
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
                    'Not A User ?',
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/Register');
                    },
                    child: Text(
                      ' Register',
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

