import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  final GoogleSignIn gSignIn;
  final FirebaseUser user;

  HomeScreen({this.gSignIn, this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70.0,
              backgroundImage: NetworkImage(widget.user.photoUrl,),
            ),
            SizedBox(height: 10,),
            Text("Logged in as ${widget.user.email}",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w900),),
            
            SizedBox(height: 10,),
            Text("Dispay name is ${widget.user.displayName}",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w900),),


            SizedBox(height: 10,),
            RaisedButton(
              color: Colors.red,
              child: Text("Signout",style: TextStyle(color: Colors.white),),
              onPressed: () {
                widget.gSignIn.signOut();
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
