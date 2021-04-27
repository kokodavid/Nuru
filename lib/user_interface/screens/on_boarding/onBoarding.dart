import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nuru/helpers/authenticate.dart';
import 'package:nuru/helpers/constant.dart';


class OnBoardingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //introduction screens
      body: IntroductionScreen(
        pages: screens,
        //Done Button Functionality
        onDone: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Authenticate()
          ));
        },
        //Display Skip Button
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        //Buttons and Designs
        skip: const Text('Skip',style:TextStyle(color: kBlack),),
        next: const Icon(Icons.arrow_forward,color: kBlack,),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600,color: kBlack)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: kIsWeb ? const EdgeInsets.all(12.0): const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: dotsDecorator,
        dotsContainerDecorator: dotsContainerDecorator
      )
    );
  }
}