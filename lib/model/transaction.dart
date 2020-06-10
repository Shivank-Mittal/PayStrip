import 'package:firebase_database/firebase_database.dart';

class Transaction{

  String _id;
  String _name;
  String _amount;
  String _email;
  String _transactionId;

  // For add transaction

  Transaction(this._name,this._amount, this._email, this._transactionId);

  String get name => this._name;
  String get id => this._id;
  String get amount => this._amount;
  String get email => this._email;
  String get transactionId => this._transactionId;

  set name(String name){
    this._name = name;
  }

  set amount(String amount){
    this._amount = amount;
  }
  set email(String email){
    this._email = email;
  }
  set transactionId(String transactionId){
    this._transactionId = transactionId;
  }
  
  Transaction.fromSnapshot(DataSnapshot snapshot){
    this._id = snapshot.key;
    this._name = snapshot.value['name'];
    this._amount = snapshot.value['amount'];
    this._email = snapshot.value['email'];
    this._transactionId = snapshot.value['transactionId'];
  }

  Map<String, dynamic> toJson(){
    return{
      "name":_name,
      "amount" : _amount,
      "email" : _email,
      "transactionId" : _transactionId
    };
  }
}