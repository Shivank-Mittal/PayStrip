
import 'package:firebase_database/firebase_database.dart';
import 'model/transaction.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService{


  final FirebaseAuth _auth = FirebaseAuth.instance;

  saveTransactionToDatabase(String name , String amount , String email, String transactionId) async{
    Transaction transaction = Transaction(name, amount, email, transactionId);

    DatabaseReference _dbReference = FirebaseDatabase.instance.reference();
    await _dbReference.push().set(transaction.toJson());

  }

  Future<FirebaseUser> getUser() async {

    FirebaseUser firebaseUser = await _auth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser();

    return firebaseUser;
  }
}