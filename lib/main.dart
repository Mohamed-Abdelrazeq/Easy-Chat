import 'package:easychat_app/Controllers/UserProvider.dart';
import 'package:easychat_app/Views/Screens/ChatScreen.dart';
import 'package:easychat_app/Views/Screens/TestScreen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'Views/Screens/Loading.dart';
import 'Views/Screens/LoginScreen.dart';
import 'Views/Screens/RegisterScreen.dart';
import 'Views/Screens/SomethingIsWrong.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
    ],
    child: App(),
  ),);
}

class App extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/Register': (context) => RegisterScreen(),
        '/Login': (context) => LoginScreen(),
        '/Test': (context) => TestScreen(),
        '/ChatScreen': (context) => ChatScreen(),
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




