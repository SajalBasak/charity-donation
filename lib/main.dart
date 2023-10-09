import 'package:flutter/material.dart';
import 'package:charity_donation/screens/feed.dart';
import 'package:charity_donation/screens/donationDetails.dart';
import 'package:charity_donation/screens/payment.dart';
import 'package:charity_donation/screens/signin/signin.dart';
import 'package:charity_donation/screens/signup/signup.dart';
import 'package:charity_donation/theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      initialRoute: Feed.routeId,
      routes: {
        Feed.routeId: (context) => Feed(),
        DonationDetails.routeId: (context) => DonationDetails(),
        Payment.routeId: (context) => Payment(),
        SignIn.routeId: (context) => SignIn(),
        SignUp.routeId: (context) => SignUp(),
      },
    );
  }
}
