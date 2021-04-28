import 'package:flutter/material.dart';
import 'package:nuru/helpers/constant.dart';

class MenuItems extends StatelessWidget{
  const MenuItems({
    Key? key, required this.text,required this.press
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // ignore: unnecessary_statements
        press;
        print("pressers");
      },
      child: Container(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:8.0,vertical: 8),
          child: Row(
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text(text,style: mediumTextStyle(),),
              ),
              Spacer(flex: 2,),
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_forward_ios,color: kYellow,size: 17,),
              ),
            ],
          ),
        ),
      ),
    );

  }



}