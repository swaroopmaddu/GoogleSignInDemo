import 'package:GoogleSignInDemo/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GSignInDemo(),
    );
  }
}

final GoogleSignIn _gSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

class GSignInDemo extends StatefulWidget {
  @override
  _GSignInDemoState createState() => _GSignInDemoState();
}

class _GSignInDemoState extends State<GSignInDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        child: Center(
          child: GestureDetector(
            onTap: () async{
              onGoogleSignIn(context);
            },
            child: Container(
              width: 200,
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.blue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person,color: Colors.white,size: 25,),
                  SizedBox(width:10),
                  Text("Signin With Google",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onGoogleSignIn(BuildContext context) async {
    FirebaseUser user = await _controlSignIn();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(user: user, gSignIn: _gSignIn),
      ),
    );
  }

  Future<FirebaseUser> _controlSignIn() async {
    final GoogleSignInAccount googleUser = await _gSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }
}
