import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {

  DatabaseReference _databaseRefrence = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('TransactionList'),
      ),
      body: Container(
        child: FirebaseAnimatedList(
          query: _databaseRefrence,
          itemBuilder: (BuildContext context , DataSnapshot snataSnapsot, Animation<double> animation, int index ){
            return  Card(
              color: Colors.deepPurpleAccent,
              elevation: 10,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[ 
                    Container(
                      child: Text("${snataSnapsot.value['name']}", style:TextStyle(fontSize: 15,color: Colors.white), ), ),
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Text("${snataSnapsot.value['amount']}"+"\$",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ,color: Colors.white),
                      ),
                    ),
                    
                  ],
                )
              ),
            );
          }
        ),
      ) ,
    );
  }
}