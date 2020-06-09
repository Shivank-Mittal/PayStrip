import 'package:flutter/material.dart';
import 'package:payStrip/ExistingCards.dart';
import 'HomePage.dart';
import 'SignInPage.dart';
import 'SignUpPage.dart';

void main() => runApp(PayStrip());

class PayStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pay Stripe",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple ),
      home : HomePage(),
      routes: <String,WidgetBuilder>{
        "/SignInPage":(BuildContext context) =>SigninPage(),
        "/SignUpPage":(BuildContext context) =>SignupPage(),
        "/ExistingCards":(BuildContext context) =>ExistingCardsPage(),

      },
    );
  }
}
