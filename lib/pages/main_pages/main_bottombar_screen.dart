import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizlen/constants/text_constants.dart';
import 'package:quizlen/pages/authentication_pages/login_page.dart';
import 'package:quizlen/pages/authentication_pages/signup_page.dart';
import 'package:quizlen/pages/main_pages/after_game_screen.dart';
import 'package:quizlen/pages/main_pages/categories_screen.dart';
import 'package:quizlen/pages/main_pages/edit_profile_screen.dart';
import 'package:quizlen/pages/main_pages/home_screen.dart';
import 'package:quizlen/pages/main_pages/leaderboard_screen.dart';
import 'package:quizlen/pages/main_pages/quiz_copy.dart';
import 'package:quizlen/pages/main_pages/quiz_screen.dart';
import 'package:quizlen/pages/main_pages/tester.dart';

void main() => runApp(MainBottomBarScreen());

class MainBottomBarScreen extends StatefulWidget {
  @override
  State<MainBottomBarScreen> createState() => _MainBottomBarScreenState();
}

class _MainBottomBarScreenState extends State<MainBottomBarScreen> {
  PageController _pageController = PageController();

  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xff595CFF),width: 2))
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  showUnselectedLabels: false,
                  unselectedItemColor: Colors.grey,
                  iconSize: 35,
                  backgroundColor: Color(0xFF1E2059),
                  landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      label: 'Home',
                      backgroundColor: Colors.grey,
                    ),
                    BottomNavigationBarItem(

                      icon: Icon(Icons.leaderboard_outlined),
                      label: 'Leaderboard',
                      backgroundColor: Colors.grey,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle_outlined),
                      label: 'Profile',
                      backgroundColor: Colors.grey,
                    ),
                  ],
                  selectedLabelStyle: GoogleFonts.montserrat(),
                  currentIndex: _selectedIndex,
                  selectedItemColor: Colors.white,
                  onTap: _onItemTapped,
                ),
              ),
              body: SizedBox.expand(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _selectedIndex = index);
                  },
                  children: <Widget>[
                    HomeScreen(),
                    LeaderboardScreen(),
                    EditProfileScreen(),
                  ],
                ),
              ),
            );
          }

          else {
            return LoginPage();
          }



        });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      //
      //
      //using this page controller you can make beautiful animation effects
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    });
  }
}
