import 'package:flutter/material.dart';
import 'package:nuru/helpers/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuru/user_interface/screens/profile/edit_profile_screen.dart';
import 'package:nuru/user_interface/screens/profile/menu_items.dart';


class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late  bool _isSubmitting;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical:18.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: Image.asset("assets/images/profile_picture.png", height: 70,width: 70,)),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical:10,horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Koko David" ,style: mediumTextStyle()),
                              SizedBox(height: 8,),
                              Text("kokodavid@gmail.com" ,style: mediumTextStyle()),
                            ],
                          ),

                        ),
                        Spacer(flex: 1,),
                        GestureDetector(
                          onTap: ()async{
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));

                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:5.0),
                            child: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 30),
                child: Column(
                  children: [
                    SizedBox(height: 10.h,),
                    Container(
                      color: Colors.white60,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:8.0,),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  MenuItems( text: "About Nuru.live",press: (){
                                      comingSoon();
                                    },
                                  ),
                                  Divider(color: Color(0xFFC6C6C6),indent: 10,endIndent: 10,),
                                  MenuItems( text: "Nuru Data Dashboard",press: (){_showErrorSnack("Coming Soon");},),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 1.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(1.0, 1.0), // shadow direction: bottom right
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  MenuItems( text: "Content Policy",press: (){_showErrorSnack("Coming Soon");},),
                                  Divider(color: Color(0xFFC6C6C6),indent: 10,endIndent: 10,),
                                  MenuItems( text: "Privacy Policy",press: (){_showErrorSnack("Coming Soon");},),
                                  Divider(color: Color(0xFFC6C6C6),indent: 10,endIndent: 10,),
                                  MenuItems( text: "Terms of Use",press: (){_showErrorSnack("Coming Soon");},),


                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h,),
                        ],
                      ),
                    ),
                    Text("Version 1.1.0",style: TextStyle(fontSize: 15),)

                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  comingSoon(){
     _showErrorSnack("Coming Soon");

  }

  _showErrorSnack(String message) {
    final snackbar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.yellow.shade100,
      duration: Duration(milliseconds: 2500),
      content: Text(
        "$message",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    // ignore: deprecated_member_use
    _scaffoldKey.currentState!.hideCurrentSnackBar();
    // ignore: deprecated_member_use
    _scaffoldKey.currentState!.showSnackBar(snackbar);
    setState(() {
      _isSubmitting = false;
    });
  }
}
