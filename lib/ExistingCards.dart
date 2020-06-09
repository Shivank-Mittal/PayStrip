import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'payment-service.dart';

class ExistingCardsPage extends StatefulWidget {
  @override
  _ExistingCardsPageState createState() => _ExistingCardsPageState();
}

class _ExistingCardsPageState extends State<ExistingCardsPage> {

  List cards = [{
    'cardNumber': '4242424242424242',
    'expiryDate': '04/24',
    'cardHolderName': 'Shivank Mittal',
    'cvvCode': '424',
    'showBackView': false,
  }, {
    'cardNumber': '5555555566554444',
    'expiryDate': '04/23',
    'cardHolderName': 'MSD',
    'cvvCode': '123',
    'showBackView': false,
  }];

  payViaExistingContext(BuildContext context,dynamic card){

    var responce = StripeService.payViaExistingCard( amount: '200',currency: 'EURO',card : card);

        if(responce.success == true){
          Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green ,
              content: Text(responce.message),
              duration: new Duration(milliseconds: 1200),
              ),
          ).closed.then((_){
            Navigator.pop(context);
          }
        ) ;
    
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chose existing card'),
      ),
      body : Container(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: cards.length,
          itemBuilder: (BuildContext context, int index){
            var card = cards[index];
            return InkWell(
              child: CreditCardWidget(
                  cardNumber: card['cardNumber'],
                  expiryDate: card['expiryDate'], 
                  cardHolderName: card['cardHolderName'],
                  cvvCode: card['cvvCode'],
                  showBackView: false, //true when you want to show cvv(back) view
              ),
              onTap: (){
                payViaExistingContext(context, card);
              },
            );
          },
        ),
      )
    );
  }
}