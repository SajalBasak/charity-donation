import 'package:flutter/material.dart';
import 'package:charity_donation/constants.dart';
import 'package:charity_donation/screens/signin/signin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool remember = false;

  bool showSpin = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: 30),
          buildPasswordFormField(),
          SizedBox(height: 30),
          buildConformPassFormField(),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              try {
                final newUser = await _auth.createUserWithEmailAndPassword(
                    email: email, password: password);
                if (newUser != null) {
                  Navigator.pushNamed(context, SignIn.routeId);
                }
                setState(() {
                  showSpin = false;
                });
              } catch (e) {
                print(e);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 15.0, horizontal: 20.0),
              child: Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: kPrimaryColor,
              shadowColor: Colors.grey,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) {
        password = value;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 25.0),
          child: Icon(
            FontAwesomeIcons.lock,
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) {
        password = value;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 25.0),
          child: Icon(
            FontAwesomeIcons.lock,
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        email = value;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 25.0),
          child: Icon(
            FontAwesomeIcons.solidEnvelope,
          ),
        ),
      ),
    );
  }
}
