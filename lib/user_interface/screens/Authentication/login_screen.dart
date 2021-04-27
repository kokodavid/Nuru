import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nuru/helpers/auth_repo.dart';
import 'package:nuru/helpers/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuru/helpers/locator.dart';
import 'package:nuru/helpers/user_controller.dart';
import 'package:nuru/user_interface/screens/Authentication/forgot_password.dart';
import 'package:nuru/user_interface/screens/landing_page/home.dart';
import 'package:nuru/user_interface/screens/landing_page/home_screen.dart';


class LoginScreen extends StatefulWidget {
  final Function toggle;
  LoginScreen(this.toggle);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late  bool _isSubmitting;
  FirebaseAuth auth = FirebaseAuth.instance;
  late User _currentUser;
  AuthRepo authMethods = AuthRepo();
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthRepo _authRepo = locator.get<AuthRepo>();
  TextEditingController passWordTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = _isLoading
        ? new SpinKitRipple(
      color: kYellow,
      size: 48.r,
    )
        : new Container();
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical:60.0.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/nuru_logo_trans.png',
                                  height: 100,
                                  width: 150,
                                ),
                                Text(
                                  "Please Login to Access more features",
                                  style: TextStyle(
                                      color: Colors.black
                                  ),
                                ),
                                SizedBox(height: 15.h,),
                                Padding(
                                  padding: const EdgeInsets.only(top:50.0),
                                  child: TextFormField(
                                    validator: (val){
                                      return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val!)
                                          ? null
                                          : "Enter a valid Email";
                                    },
                                    controller: emailTextEditingController,
                                    style: simpleTextStyle(),
                                    decoration: textFieldInputDecoration("Email Address"),

                                  ),
                                ),
                                SizedBox(height: 20.h,),
                                TextFormField(
                                    obscureText: true,
                                    ///ToDo
                                    // validator: (val){
                                    //   return val!.length < 0 ? null : "Please provide a Password with four digits";
                                    // },
                                    controller: passWordTextEditingController,
                                    style: simpleTextStyle(),
                                    decoration: textFieldInputDecoration("Password")
                                ),
                                SizedBox(height: 8.h,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));

                                  },
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child:   Container(
                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      child: Text(
                                        "Forgot Password ?",
                                        style: TextStyle(color: kYellow,fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h,),

                                new Align(
                                  child: loadingIndicator,
                                  alignment: FractionalOffset.topCenter,
                                ),
                                SizedBox(height: 8.h,),
                                GestureDetector(
                                  onTap: (){
                                    login();
                                    print("Print");
                                  },
                                  child: Container(
                                    child: Text("LOGIN",style: TextStyle(color: Colors.white),),
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        gradient: LinearGradient(
                                            colors: [
                                              kYellow,
                                              kYellow
                                            ]
                                        )
                                    ),
                                  ),

                                ),
                                SizedBox(height: 20.0.h),
                                Text(
                                  'OR',
                                  style: regularStyle,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //google
                                    MaterialButton(
                                      onPressed: () {
                                        // Navigator.pushReplacement(
                                        //     context, MaterialPageRoute(builder: (context) => HomePage()));
                                        // signInWithGoogle();
                                      },
                                      padding: EdgeInsets.symmetric(horizontal: 8.r),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            child: Image.asset(
                                              'assets/images/google_icon.png',
                                              height: 19.r,
                                              width: 19.r,
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Text('Google Login', style: regularStyle),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h,),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Need an Account ? ",style: mediumTextStyle(),),
                                      GestureDetector(
                                        onTap: (){
                                          widget.toggle();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 8),
                                          child: Text("Sign Up",style: TextStyle(
                                              color: kYellow,
                                              fontSize: 17,
                                              decoration: TextDecoration.underline
                                          )
                                            ,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5.h),

                              ],
                            ),
                          )),
                    ],
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }

  login() {
    if (formKey.currentState!.validate()) {
      _LoginUser();
    }
  }

  // ignore: non_constant_identifier_names
  _LoginUser() async {
    setState(() {
      _isSubmitting = true;
      _isLoading = true;
    });

    final logMessage = await locator.get<UserController>().signInWithEmailAndPassword(email: emailTextEditingController.text, password: passWordTextEditingController.text);

    // if (!auth.currentUser.emailVerified) {
    //   _showErrorSnack("An email has just been sent to you, Click the link provided to complete registration");
    //   setState(() {
    //     _isLoading = false;
    //   });
    // } else if (auth.currentUser.emailVerified == true) {
    if (logMessage == "Logged In Successfully") {

      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => Home()
      ));

      return;
    } else {
      setState(() {
        _isSubmitting = false;
        _isLoading = false;
      });
    }


    // ignore: unnecessary_statements
    logMessage == "Logged In Successfully" ? null : _showErrorSnack(logMessage);

    //print("I am logMessage $logMessage");
  }


  _showErrorSnack(String message) {
    final snackbar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color(0xFFFFD67B),
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
