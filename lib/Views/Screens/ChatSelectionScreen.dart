import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easychat_app/Controllers/ChatProvider.dart';
import 'package:easychat_app/Views/Component/Spanner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: height*.1,
              width: width,
              padding: EdgeInsets.symmetric(horizontal: width*.05),
              color: Colors.teal,
              child: Row(
                children: <Widget>[
                  Icon(Icons.menu,color: Colors.white,size: height*.04,),
                  SizedBox(width: width*.2,),
                  Text(
                    'easy-chat',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 36
                    ),
                  )//todo make it do something like logout
                ],
              ),
            ),
            Container(
              height: height*.9 ,
              width: width,
              color: Colors.white,
              padding: EdgeInsets.only(top: 15),
              child: UsersStream(width: width,),
            )
          ],
        ),
      ),
    );
  }
}

class UsersCard extends StatelessWidget {

  final String receiverEmail;
  final String receiverUsername;

  UsersCard({@required this.receiverEmail,@required this.receiverUsername});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom);
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        Provider.of<ChatProvider>(context,listen: false).receiverEmailSetter(receiverEmail);
        Provider.of<ChatProvider>(context,listen: false).receiverUsernameSetter(receiverUsername);
        Navigator.pushNamed(
          context,
          '/ChatScreen'
        );
      },
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.account_circle,size: height*0.06,),
            title: Text(receiverUsername,style: TextStyle(fontSize: height*.03,fontWeight: FontWeight.bold),),
            subtitle: Text("$receiverEmail"),
            trailing: Icon(Icons.menu),
          ),
          Row(
                children: [
                  SizedBox(width: width*.17,),
                  Container(
                    width: width*.8,
                    child: Divider(thickness: .5,color: Colors.teal,),
                  ),
                ],
              ),

        ],
      ),
    );
  }
}

class UsersStream extends StatelessWidget {

  UsersStream({
    @required this.width
  });

  final double width;
  final CollectionReference users = FirebaseFirestore.instance.collection('Users');

  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return spanner;
        }
        return ListView(
          physics: BouncingScrollPhysics(),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return UsersCard(receiverEmail: document.data()['Email'],receiverUsername: document.data()['Username'],);
          }).toList(),
        );
      },
    );
  }
}
