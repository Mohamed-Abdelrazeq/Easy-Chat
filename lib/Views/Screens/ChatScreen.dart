import 'package:easychat_app/Views/Component/Spanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

TextEditingController messageController = TextEditingController();

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            child: ListView(
              children: [
                Header(width: width, height: height),
                SizedBox(height: 10,),
                Container(
                  height: height * .75,
                  child: MessagingStream(
                    width: width,
                  ),
                ),
                MessageSender(width: width, height: height),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessagingStream extends StatelessWidget {
  MessagingStream({Key key, this.width}) : super(key: key);

  final double width;

  Widget build(BuildContext context) {
    CollectionReference messages =
        FirebaseFirestore.instance.collection('Messages');

    return StreamBuilder<QuerySnapshot>(
      stream: messages.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return spanner;
        }
        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            var sender = document.data()['Sender'];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: width * .03),
              decoration: BoxDecoration(
                color: sender == 'user1' ? Colors.teal : Colors.blue,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ListTile(
                title: Text(
                  document.data()['Message'],
                  style: TextStyle(color: Colors.white),
                  textAlign:
                      sender == 'user1' ? TextAlign.left : TextAlign.right,
                ),
                subtitle: Text(
                  document.data()['Sender'],
                  style: TextStyle(color: Colors.white70),
                  textAlign:
                      sender == 'user1' ? TextAlign.left : TextAlign.right,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      width: width,
      height: height * .1,
      padding: EdgeInsets.only(left: width * .05, top: height * .02),
      child: Center(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
                size: height * .04,
              ),
            ),
            SizedBox(width: width * .26),
            Text(
              'User2',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: height * .05,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageSender extends StatelessWidget {
  const MessageSender({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: width * .05, right: width * .05, bottom: height * .02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width * .7,
            height: height * .08,
            padding: EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(height)),
            child: TextField(),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: height * .08,
              // width: width*.05,
              // padding: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal,
                // borderRadius: BorderRadius.circular(height)
              ),
              child: Center(
                  child: Icon(
                Icons.send,
                color: Colors.white,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
