import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'Views/Screens/Loading.dart';
import 'Views/Screens/LoginScreen.dart';
import 'Views/Screens/RegisterScreen.dart';
import 'Views/Screens/SomethingIsWrong.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/Register': (context) => RegisterScreen(),
        '/Login': (context) => LoginScreen(),
      },
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return SomethingWentWrong();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen();
          }
          return Loading();
        },
      ),
    );
  }
}




