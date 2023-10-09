import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:charity_donation/screens/signin/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Feed extends StatefulWidget {
  static const String routeId = 'feed';

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget categoryBuilder(IconData categoryIcon, String categoryTitle,
      Color bgColor, Color iconColor) {
    print(MediaQuery.of(context).size.width);
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            categoryIcon,
            size: 28.0,
            color: iconColor,
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            categoryTitle,
            style: TextStyle(
              fontFamily: 'MavenPro',
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<String> trendingImages = [
    'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
    'https://images.unsplash.com/photo-1527613426441-4da17471b66d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1035&q=80',
    'https://images.unsplash.com/photo-1593113598332-cd288d649433?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
    'https://images.unsplash.com/photo-1566938064504-a379175168b3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1050&q=80',
  ];

  Widget trendingSection(
      String imagePath, double raisedAmount, double maxAmount, String title) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        width: 260.0,
        height: 280.0,
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image(
                  image: NetworkImage(imagePath),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'MavenPro',
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Slider(
              value: raisedAmount,
              max: maxAmount,
              activeColor: Colors.green,
              inactiveColor: Colors.grey,
              onChanged: (double newValue) {},
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "${raisedAmount.toString()} raised from ${maxAmount.toString()}",
                style: TextStyle(
                  fontFamily: 'MavenPro',
                  fontSize: 14.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        defaultSelectedItemIndex: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Smiley.',
                            style: TextStyle(
                              fontFamily: 'Caveat',
                              fontSize: 25.0,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              TypewriterAnimatedText(
                                'donate, smile, spread happiness',
                                textStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'MavenPro',
                                ),
                                speed: const Duration(milliseconds: 85),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search_rounded,
                    ),
                    color: Colors.grey[700],
                    iconSize: 30.0,
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Trending',
                    style: TextStyle(
                      fontFamily: 'MavenPro',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    trendingSection(trendingImages[0], 3700, 10000,
                        "Help the children in Congo"),
                    trendingSection(trendingImages[1], 55, 1000,
                        "Medical support in Taiwan"),
                    trendingSection(
                        trendingImages[2], 800, 1200, "Disaster in Japan"),
                    trendingSection(
                        trendingImages[3], 176, 1000, "Plantation in Italy"),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontFamily: 'MavenPro',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  categoryBuilder(
                    FontAwesomeIcons.userGraduate,
                    'Education',
                    Colors.blue,
                    Color(0XFF01579B),
                  ),
                  categoryBuilder(
                    FontAwesomeIcons.briefcaseMedical,
                    'Medical',
                    Colors.cyanAccent,
                    Color(0XFF0097A7),
                  ),
                  categoryBuilder(
                    FontAwesomeIcons.houseDamage,
                    'Disaster',
                    Color(0XFFD7BB98),
                    Color(0XFFD7777C),
                  ),
                  categoryBuilder(
                    FontAwesomeIcons.accusoft,
                    'Others',
                    Color(0XFFA772C8),
                    Color(0XFFA66348),
                  ),
                ],
              ),
            ],
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
