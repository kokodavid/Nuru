import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

//Image Builder used in Introduction Slider
Widget buildImage(String assetName, [double width = 250]) {
  return Image.asset('assets/images/$assetName', width: width);
}

//constant style for text
const bodyStyle = TextStyle(fontSize: 19.0);

//Constant Colors
const kYellow = Color(0xFFF6B21A);
const kBlack = Color(0xFF000000);

//page decoration widget
const pageDecoration = const PageDecoration(
  titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
  bodyTextStyle: bodyStyle,
  descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
  pageColor: Colors.white,
  imagePadding: EdgeInsets.zero,
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
    title: "Collecting Data",
    body:
    "Instead of having to buy an entire share, invest any amount you want.",
    image: buildImage('nurunew.jpg'),
    decoration: pageDecoration,
  ),
  PageViewModel(
    title: "Data Analysis",
    body:
    "Instead of having to buy an entire share, invest any amount you want.",
    image: buildImage('nurunew.jpg'),
    decoration: pageDecoration,
  ),
  PageViewModel(
    title: "Reports Submission",
    body:
    "Instead of having to buy an entire share, invest any amount you want.",
    image: buildImage('nurunew.jpg'),
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
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.white54,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
      )
  );

}

//Text Styles
TextStyle simpleTextStyle(){
  return TextStyle(
      color: Colors.white,
      fontSize: 16
  );
}

TextStyle mediumTextStyle(){
  return TextStyle(
      color: Colors.white,
      fontSize: 17
  );
}