import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nuru/helpers/authenticate.dart';
import 'package:nuru/helpers/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuru/helpers/locator.dart';
import 'package:nuru/helpers/user_controller.dart';


class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late  bool _isSubmitting;
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController emailTextEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = _isLoading
        ? new SpinKitRipple(
      color: kYellow,
      size: 48.r,
    )
        : new Container();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Forgot Password"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal:24,vertical: 24),
                  child: Text("Enter the Email address to registered"
                      " with and we will send you a link to reset your pin",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                    ),),
                ),
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
                SizedBox(height: 20.h,),
                new Align(
                  child: loadingIndicator,
                  alignment: FractionalOffset.topCenter,
                ),
                SizedBox(height: 30.h,),
                GestureDetector(
                  onTap: (){
                    forgotPassword();
                    print(emailTextEditingController.text);
                  },
                  child: Container(
                    child: Text("SUBMIT",style: TextStyle(color: Colors.white),),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  forgotPassword() {
    if (formKey.currentState!.validate()) {
      _ForgotPassword();
    }
  }

  _ForgotPassword()async{

    setState(() {
      _isSubmitting = true;
      _isLoading = true;
    });

    final logMessage = await locator.get<UserController>().resetPassword(emailTextEditingController.text);

    if(logMessage == "Successful" ){
      setState(() {
        _isSubmitting = false;
        _isLoading = false;
      });
      await _showErrorSnack("Email to reset password has been sent");
      // Navigator.pushReplacement(context, MaterialPageRoute(
      //     builder: (context) => Authenticate()
      // ));
    }else{
      setState(() {
        _isSubmitting = false;
        _isLoading = false;
      });
    }

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
