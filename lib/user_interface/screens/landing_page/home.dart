import 'package:flutter/material.dart';
import 'package:nuru/helpers/constant.dart';
import 'package:nuru/user_interface/screens/landing_page/add_posts.dart';
import 'package:nuru/user_interface/screens/landing_page/home_screen.dart';
import 'package:nuru/user_interface/screens/landing_page/profile_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> tabPages = [
    HomeScreen(),
    AddPostsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7FFFF),
      body: tabPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: new Image.asset('assets/images/home_icon.png',height: 20,width:20,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: new Image.asset('assets/images/add_post.png',height: 20,width:20,),
            label: 'Add Post',
          ),
          BottomNavigationBarItem(
            icon: new Image.asset('assets/images/profile.png',height: 20,width:20,),
            label: 'Profile',
          ),
        ],
        selectedItemColor: kYellow,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
