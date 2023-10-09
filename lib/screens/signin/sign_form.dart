import 'package:flutter/material.dart';
import 'package:charity_donation/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:charity_donation/screens/feed.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool remember = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: 20),
          buildPasswordFormField(),
          SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              try {
                final user = await _auth.signInWithEmailAndPassword(
                    email: email, password: password);
                if (user != null) {
                  Navigator.pushNamed(context, Feed.routeId);
                }
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      //onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        password = value;
      },
      // validator: (value) {},
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
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
      //onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        email = value;
      },
      // validator: (value) {},
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
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
