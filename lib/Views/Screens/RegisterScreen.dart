import 'package:easychat_app/Views/Component/MyTextField.dart';
import 'package:flutter/material.dart';

TextEditingController firstName = TextEditingController();
TextEditingController secondName = TextEditingController();

class RegisterScreen extends StatelessWidget {
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
              MyTextField(hint: "Email",controller: firstName,),
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
              MyTextField(hint: 'Password',controller: secondName,),
              SizedBox(height: height*.1,),
              GestureDetector(
                onTap: () async {
                  //Register to auth
                  FocusScope.of(context).requestFocus(FocusNode());
                  firstName.clear();
                  secondName.clear();
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