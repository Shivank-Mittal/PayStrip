import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser user;
  bool isSignedIn = false;

  chechAuthentication() async {
    _auth.onAuthStateChanged.listen((user) { 
      if(user == null ){
        Navigator.pushReplacementNamed(context, "/SignInPage");
      }
    });
  }

  getUser() async {
    FirebaseUser firebaseUser = await _auth.currentUser();

    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser();

    if(firebaseUser != null) 
    {
      setState(() {
          this.user = firebaseUser;
          this.isSignedIn = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();
  }

  @override
  void initState(){
    super.initState();
    this.chechAuthentication();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar( 
        title: Text(user.displayName),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new,size: 30.0,),
            onPressed: (){
              signOut();
            },
          ),
          
          Padding(padding: EdgeInsets.all(10)),
        ],
        ),
      body: Container(
        child: Center(
          child: !isSignedIn
          ? CircularProgressIndicator()
          : Column(
            children: <Widget>[
              Container(
                padding:  EdgeInsets.all(50),
                child: Image(image: AssetImage("images/logo.png"),
                width: 100.0,
                height: 100.0,
                ),
              ),
              Container(
                child: Card(
                  elevation: 40,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child:TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Amount',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                            ),
                          ) ,
                        ),
                      )
                      
                    ],
                  ),
                ),
              )
              // Container(
              //   padding: EdgeInsets.all(50.0),
              //   child: Text(
              //     "Hello, ${user.displayName}, you are locked in as ${user.email} ",
              //     style: TextStyle(fontSize: 20.0),
              //   ),
              // ),
              // Container(
              //   padding: EdgeInsets.all(20),
              //   child: RaisedButton(
              //     color: Colors.purple,
              //     padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              //     onPressed: (){signOut();},
              //     child: Text('Signout', style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 20.0
              //         ),
              //     ),
              //   ),
                
              // )
            ],
          )
        ),
      ),
    );
  }
}