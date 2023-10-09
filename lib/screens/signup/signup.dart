import 'package:flutter/material.dart';
import 'package:charity_donation/screens/feed.dart';
import 'package:charity_donation/screens/signin/signin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:charity_donation/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUp extends StatefulWidget {
  static String routeId = 'signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool remember = false;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        defaultSelectedItemIndex: 4,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        height:
                            MediaQuery.of(context).size.height * 0.04), // 4%
                    Text(
                      "Register Account",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Complete your details or continue \nwith social media",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                    Form(
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
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                final newUser =
                                    await _auth.createUserWithEmailAndPassword(
                                        email: email, password: password);
                                if (newUser != null) {
                                  Navigator.pushNamed(context, SignIn.routeId);
                                }
                                setState(() {
                                  showSpinner = false;
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
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'By continuing your confirm that you agree \nwith our Term and Condition',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
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

class CustomBottomNavBar extends StatefulWidget {
  final defaultSelectedItemIndex;

  CustomBottomNavBar({this.defaultSelectedItemIndex});

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int selectedItemIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedItemIndex = widget.defaultSelectedItemIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildBottomNavItems(FontAwesomeIcons.home, 0, Feed.routeId),
        buildBottomNavItems(FontAwesomeIcons.calendarAlt, 1, ''),
        buildBottomNavItems(FontAwesomeIcons.plusSquare, 2, ''),
        buildBottomNavItems(FontAwesomeIcons.infoCircle, 3, ''),
        buildBottomNavItems(FontAwesomeIcons.userAlt, 4, SignIn.routeId),
      ],
    );
  }

  Widget buildBottomNavItems(IconData icon, int index, String route) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItemIndex = index;
        });
        Navigator.pushNamed(context, route);
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 5,
        decoration: index == selectedItemIndex
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 4,
                    color: Colors.blue,
                  ),
                ),
                // gradient: LinearGradient(
                //   colors: [
                //     Colors.blue.withOpacity(0.3),
                //     Colors.blue.withOpacity(0.015),
                //   ],
                //   begin: Alignment.bottomCenter,
                //   end: Alignment.topCenter,
                // ),
              )
            : BoxDecoration(),
        child: Icon(
          icon,
          color: index == selectedItemIndex ? Colors.black : Colors.grey[700],
        ),
      ),
    );
  }
}
