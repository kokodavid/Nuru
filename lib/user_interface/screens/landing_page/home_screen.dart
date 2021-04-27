import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:nuru/helpers/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuru/helpers/form_input_decoration.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 130.h,
                decoration: new BoxDecoration(
                  color: kYellow,
                    borderRadius: new BorderRadius.only(
                      bottomLeft: const Radius.circular(20.0),
                      bottomRight: const Radius.circular(20.0),
                    )
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 10),
                      child: Align(
                       alignment: Alignment.centerLeft,
                        child: Text(
                        "Search",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,fontWeight: FontWeight.bold
                        ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                        ),
                        decoration: formInputDecoration(
                          isDense: true,
                          hintText: "Search For Posts",
                          prefixIcon: Icons.search,
                        ),
                        controller: searchController,
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 30.h,),
              Align(
                alignment: Alignment.center,
                child: Center(
                    child: Image.asset("assets/images/not_found.png")
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
