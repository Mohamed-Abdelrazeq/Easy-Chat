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
    return Scaffold(
      body: Center(
        child: Text('Chat Screen'),
      ),
    );
  }
}
