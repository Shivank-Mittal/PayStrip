import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:payStrip/payment-service.dart';

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

  onItemPress(BuildContext context , int index)  async{
    print('index : ${index.toString()}');

    switch (index) {
      case 0:
        var responce = await StripeService.payWithNewCard( amount: '200',currency: 'EURO' );

        if(responce.success == true){
          Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green ,
              content: Text(responce.message),
              duration: new Duration(milliseconds: 1200),),
          );
        }
        break;
      case 1:
        Navigator.pushNamed(context, "/ExistingCards");
      break;
      default:
    }
  }

  @override
  void initState(){
    super.initState();
    this.chechAuthentication();
    this.getUser();

    //To initialize stripe System 
    StripeService.init();
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
          : ListView.separated(   
            padding: EdgeInsets.all(20),
            itemBuilder: (context,index){
              Icon icon;
              Text text;

             switch(index){
               case 0:
                  icon = Icon(Icons.add_circle, color: Colors.purple,);
                  text = Text('Donate via new card');
                break;
                 case 1:
                    icon = Icon(Icons.credit_card, color: Colors.purple,);
                    text = Text('Donate via existing card');
                break;
              }
              return InkWell(
                onTap: (){
                  onItemPress(context,index);
                },
                child : ListTile(
                        title: text,
                        leading: icon,
                  ),
              );
            }, 
            separatorBuilder:(context,index) => Divider(color: Colors.purple,),
            itemCount: 2
          ) ,
        ),
      ),
    );
  }
}