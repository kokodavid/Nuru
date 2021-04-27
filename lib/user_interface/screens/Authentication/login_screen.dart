import 'package:flutter/material.dart';
import 'package:nuru/business_logic/auth.dart';
import 'package:nuru/helpers/constant.dart';
import 'package:nuru/user_interface/screens/landing_page/home_screen.dart';

class LoginScreen extends StatefulWidget {
  final Function toggle;
  LoginScreen(this.toggle);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthMethods authMethods = AuthMethods();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController passWordTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                      decoration: textFieldInputDecoration("Email")
                  ),
                  TextFormField(
                      obscureText: true,
                      validator: (val){
                        return val!.length > 6 ? null : "Please provide a Password with 6+ characters";
                      },
                      controller: passWordTextEditingController,
                      style: simpleTextStyle(),
                      decoration: textFieldInputDecoration("Password")
                  ),
                  SizedBox(height: 8,),
                  Container(
                    alignment: Alignment.centerRight,
                    child:   Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        "Forgot Password ?",
                        style: simpleTextStyle(),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  GestureDetector(
                    onTap: (){
                      login();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              colors: [
                                const Color(0xff007EF4),
                                const Color(0xff2A75BC)
                              ]
                          )
                      ),
                      child: Text("Sign In",
                        style: mediumTextStyle(),
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white
                    ),
                    child: Text("Sign In With Google",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17
                        )
                    ),
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an Account ?",style: mediumTextStyle(),),
                      GestureDetector(
                        onTap: (){
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text("Register now",style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              decoration: TextDecoration.underline
                          )
                            ,),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 50,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  login(){

    setState(() {
      isLoading = true;
    });

    if(formKey.currentState!.validate()){
      authMethods.signInWithEmailAndPassword(
          emailTextEditingController.text,
          passWordTextEditingController.text
      ).then((value){
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomeScreen()
        ));
      });
    }
  }
}
