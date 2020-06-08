import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password , _name;

  //Check every time if user is logedin or not
  checkAuthentication() async {

    _auth.onAuthStateChanged.listen((user) async{ 
      if(user != null)
      {
        // we use pushReplacementNamed isted of pushNamed becuse it will remove back button so user can to come back.
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  } 

  navigateToSignupScreen(){
    Navigator.pushReplacementNamed(context, "/SignUpPage");
  }

  @override
  void initState(){
    super.initState();
    checkAuthentication();
  }

  void signin() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();

      try{
        AuthResult user = await _auth.signInWithEmailAndPassword(email: _email, password: _password);

        //To be resolved
        if(user != null) {
          FirebaseUser _user = await FirebaseAuth.instance.currentUser();
          UserUpdateInfo updateUser = UserUpdateInfo();
          updateUser.displayName = _name;
           _user.updateProfile(updateUser);
        }
        
      }catch(e){
        showError(e);
      }
    }

    
  }

  showError(String errorMessage){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Error Box"),
          content: Text(errorMessage),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('Sign In'),),
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 50.0),
                child: Image(
                  image: AssetImage("images/logo.png"),
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        //Email
                        padding:  EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator:(input){
                            if(input.isEmpty)return 'Provide an Email';
                          } ,

                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                          ),
                          onSaved: (input) => _email = input,
                        ),
                      ),
                      Container(
                        //password
                        padding:  EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (input){
                            if(input.length < 6) {
                              return "password must be atleast 6 char";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                          ),
                          onSaved: (input) => _password = input,
                          obscureText: true,
                        ),
                      ),
                      Container(
                        //SignIn Button
                        padding:  EdgeInsets.fromLTRB(0, 20.0, 0, 40.0),
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                          color: Colors.purpleAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          child: Text('Sign In', 
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0
                                      ),
                                     ),
                          onPressed: (){
                            signin();
                          }
                          ),
                      ),
                      GestureDetector(
                        
                        onTap: (){navigateToSignupScreen();},
                        child: Text(
                          'Create and account?',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),),
      ),
    );
  }
}