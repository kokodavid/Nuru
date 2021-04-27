import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nuru/helpers/auth_repo.dart';
import 'package:nuru/helpers/authenticate.dart';
import 'package:nuru/helpers/constant.dart';
import 'package:nuru/helpers/locator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuru/helpers/user_controller.dart';
import 'package:nuru/user_interface/screens/landing_page/home_screen.dart';


class RegisterScreen extends StatefulWidget {
  final Function toggle;
  RegisterScreen(this.toggle);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late  bool _isSubmitting;
  FirebaseAuth auth = FirebaseAuth.instance;
  late User _currentUser;
  AuthRepo authMethods = AuthRepo();
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthRepo _authRepo = locator.get<AuthRepo>();
  TextEditingController passWordTextEditingController = new TextEditingController();
  TextEditingController confirmPassWordTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController phoneTextEditingController = new TextEditingController();
  TextEditingController firstNameTextEditingController = new TextEditingController();
  TextEditingController lastNameTextEditingController = new TextEditingController();
  bool _isLoading = false;
  String? countryCode;

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
                            padding:  EdgeInsets.symmetric(vertical:30.0.h),
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
                                  padding: const EdgeInsets.only(top:10.0),
                                  child: TextFormField(
                                    validator: (val) {
                                      return val!.isEmpty || val.length < 2 ? "Try another Username" : null;
                                    },
                                    controller: firstNameTextEditingController,
                                    style: simpleTextStyle(),
                                    decoration: textFieldInputDecoration("First Name"),

                                  ),
                                ),
                                SizedBox(height: 10.h,),
                                TextFormField(
                                  validator: (val) {
                                    return val!.isEmpty || val.length < 2 ? "Try another Username" : null;
                                  },
                                  controller: lastNameTextEditingController,
                                  style: simpleTextStyle(),
                                  decoration: textFieldInputDecoration("Last Name"),

                                ),
                                SizedBox(height: 10.h,),
                                TextFormField(
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
                                SizedBox(height: 10.h,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color: kYellow),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: CountryListPick(
                                          theme: CountryTheme(
                                              isShowFlag: true,
                                              isShowCode: false,
                                              isShowTitle: false
                                          ),
                                          initialSelection: '+254',
                                          onChanged: (code){
                                            countryCode = code!.dialCode;
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 18,),
                                    Container(
                                      width: 230,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: phoneTextEditingController,
                                        decoration: textFieldInputDecoration("Phone Number"),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h,),
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
                                SizedBox(height: 10.h,),
                                TextFormField(
                                    obscureText: true,
                                    ///ToDo
                                    // validator: (val){
                                    //   return val!.length < 0 ? null : "Please provide a Password with four digits";
                                    // },
                                    controller: confirmPassWordTextEditingController,
                                    style: simpleTextStyle(),
                                    decoration: textFieldInputDecoration("Confirm Password")
                                ),
                                SizedBox(height:15.h,),

                                new Align(
                                  child: loadingIndicator,
                                  alignment: FractionalOffset.topCenter,
                                ),
                                SizedBox(height: 8.h,),
                                GestureDetector(
                                  onTap: (){
                                    register();
                                    print("Print");
                                  },
                                  child: Container(
                                    child: Text("REGISTER",style: TextStyle(color: Colors.white),),
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
                                          Text('Proceed With Google', style: regularStyle),
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
                                      Text("Already have an Account ? ",style: mediumTextStyle(),),
                                      GestureDetector(
                                        onTap: (){
                                          widget.toggle();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(vertical: 8),
                                          child: Text("Login",style: TextStyle(
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

  register() {
    if (formKey.currentState!.validate()) {
      _RegisterUser();
    }
  }

  // ignore: non_constant_identifier_names
  _RegisterUser() async {
    setState(() {
      _isSubmitting = true;
      _isLoading = true;
    });


    final logMessage = await locator.get<UserController>().signUp(
        email: emailTextEditingController.text,
        password: passWordTextEditingController.text
    );


    // if (!auth.currentUser.emailVerified) {
    //   _showErrorSnack("An email has just been sent to you, Click the link provided to complete registration");
    //   setState(() {
    //     _isLoading = false;
    //   });
    // } else if (auth.currentUser.emailVerified == true) {
    if (logMessage == "Registered Successfully") {
      String phoneNumber = "$countryCode + ${phoneTextEditingController.text}";
      print(phoneNumber);
      await locator.get<UserController>().uploadProfile(
        lastName: lastNameTextEditingController.text,
        firstName: firstNameTextEditingController.text,
        phone: phoneNumber,
        email: emailTextEditingController.text,

      );
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => Authenticate()
      ));

      return;
    } else {
      setState(() {
        _isSubmitting = false;
        _isLoading = false;
      });
    }


    // ignore: unnecessary_statements
    logMessage == "Logged In Successfully" ? null : _showErrorSnack(logMessage!);

    //print("I am logMessage $logMessage");
  }

  // createUserProfile() async {
  //   print(phoneNumber);
  //
  //   try {
  //
  //   } catch (e) {
  //     print("Error:" + e.toString());
  //   }
  // }


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
