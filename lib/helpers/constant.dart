import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


//Image Builder used in Introduction Slider
Widget buildImage(String assetName, [double width = 330]) {
  return Image.asset('assets/images/$assetName', width: width,fit: BoxFit.contain,);
}

//constant style for text
const bodyStyle = TextStyle(fontSize: 19.0,fontFamily: 'Roboto');

//Constant Colors
const kYellow = Color(0xFFF6B21A);
const kBlack = Color(0xFF000000);

//page decoration widget
const pageDecoration = const PageDecoration(
  titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700,fontFamily: 'Roboto'),
  bodyTextStyle: bodyStyle,
  descriptionPadding: EdgeInsets.fromLTRB(19.0, 0.0, 16.0, 16.0),
  pageColor: Colors.white,
  imagePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
);

//Dots Decorator
const dotsDecorator = const DotsDecorator(
  size: Size(10.0, 10.0),
  color: Color(0xFFBDBDBD),
  activeColor: Color(0xFFF6B21A),
  activeSize: Size(22.0, 10.0),
  activeShape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
  ),
);

//Dots Container Decorator
const dotsContainerDecorator = const ShapeDecoration(
  color: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
);

//Introduction Screens
List<PageViewModel> screens = [
  PageViewModel(
    title: "Data Collection",
    body:
    "Nuru App Allows Data Collection in Digital Formats",
    image: buildImage('illustration_one.png'),
    decoration: pageDecoration,
  ),
  PageViewModel(
    title: "Data Analysis",
    body:
    "All Data received at Nuru is Analysed and categorically classified",
    image: buildImage('illustration_two.png'),
    decoration: pageDecoration,
  ),
  PageViewModel(
    title: "Reports Development",
    body:
    "Data Collection and Analysis play big roles in the Development of Quality Reports",
    image: buildImage('illustration_three.png'),
    decoration: pageDecoration,
  ),
];

// //App Bar Widget
// Widget appBarMain(BuildContext buildContext){
//   return AppBar(
//     title: Text("Nuru"),
//   );
// }

//Input Decoration
InputDecoration textFieldInputDecoration(String hintText){
  return InputDecoration(
    contentPadding: new EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.black,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      borderSide: BorderSide(color: kYellow),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color: kYellow)
    ),

  );

}

//Text Styles
TextStyle simpleTextStyle(){
  return TextStyle(
      color: Colors.black,
      fontSize: 16
  );
}

TextStyle mediumTextStyle(){
  return TextStyle(
      color: Colors.black,
      fontSize: 17
  );
}

TextStyle regularStyle = TextStyle(
  color: Colors.black,
  fontSize: 17.sp,
  fontFamily: 'Roboto'
);

TextStyle labelStyle = TextStyle(
  fontSize: 20.sp,
  color: Colors.white60,
);

TextStyle hintStyle = TextStyle(
  fontSize: 20.sp,
  color: Color(0xff707070),
);

Widget appBarMain(BuildContext buildContext){
  return AppBar(
    title: Text("Ssential App"),
  );
}