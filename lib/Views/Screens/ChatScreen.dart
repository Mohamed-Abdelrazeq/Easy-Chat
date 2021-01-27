import 'package:easychat_app/Views/Functions/Auth.dart';
import 'package:flutter/material.dart';

import 'Loading.dart';
import 'SomethingIsWrong.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({
    @required this.email,
    @required this.password,
  });

  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: login(email, password),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SomethingWentWrong();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != true) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Invalid User',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                    ),
                    SizedBox(height: 25,),
                    RaisedButton(
                      color: Colors.teal,
                      child: Container(
                        width: 150,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              'Try Again',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Text('Welcome'),
            );
          }
        }
        return Loading();
      },
    );
  }
}
