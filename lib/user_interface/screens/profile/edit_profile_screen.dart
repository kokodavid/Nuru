import 'dart:io';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuru/helpers/constant.dart';
import 'package:nuru/helpers/locator.dart';
import 'package:nuru/databases/profile.db.dart';
import 'package:nuru/repository/storage_repo.dart';
import 'package:nuru/helpers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:nuru/models/user_profile.dart';



class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? countryCode,firstName,secondName,email,phone;
  File? _image;
  String? updatedAvatarUrl;
  String empty = "";


  final currentUser = firebase_auth.FirebaseAuth.instance.currentUser;




  void getUpdatedAvatarUrl() async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    String downloadUrl = await locator.get<StorageRepo>().getUserProfileImage(uid);
    setState(() {
      updatedAvatarUrl = downloadUrl;
    });
  }



  // void getUserProfile()async{
  //   final uid = FirebaseAuth.instance.currentUser.uid;
  //   UserProfile userProfile = (await locator.get<UserController>().loadUserProfile(uid));
  //   setState(() {
  //       firstName = userProfile.firstName;
  //       secondName = userProfile.lastName;
  //       email = userProfile.email;
  //       phone = userProfile.phone;
  //   });
  // }

  @override
  void initState() {
    getUpdatedAvatarUrl();
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body:Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 117.h,
                      width: 155.w,
                      color: Colors.transparent,
                      child: _image == null
                          ? Center(
                        child: updatedAvatarUrl == null
                            ? Icon(
                          Icons.person_rounded,
                          color: Color(0xff31323B),
                          size: 155.0.r,
                        )
                            : CircleAvatar(
                          radius: 155.0.r,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(updatedAvatarUrl!),
                        ),
                      )
                          : CircleAvatar(
                        radius: 155.0.r,
                        backgroundColor: Colors.transparent,
                        backgroundImage: FileImage(_image!),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      padding: EdgeInsets.all(0),
                      constraints: BoxConstraints(
                        minWidth: 20.w,
                        maxWidth: 20.w,
                        maxHeight: 20.h,
                        minHeight: 20.h,
                      ),
                      icon: Icon(
                        Icons.edit,
                        size: 20.r,
                        color: kYellow,
                      ),
                      onPressed: () async {
                        // ignore: deprecated_member_use
                        File image = await ImagePicker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          if (image != null) {
                            _image = File(image.path);
                          } else {
                            print('No image selected.');
                          }
                        });
                        await locator.get<UserController>().uploadProfilePicture(_image!);
                        getUpdatedAvatarUrl();
                        print("avatarURl | $updatedAvatarUrl");

                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:15.0,),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 10),
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) {
                              return val!.isEmpty || val.length < 2 ? "Try another Username" : null;
                            },
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration("First Name"),

                          ),
                          SizedBox(height: 10.h,),
                          TextFormField(
                            validator: (val) {
                              return val!.isEmpty || val.length < 2 ? "Try another Username" : null;
                            },
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration("Second Name"),

                          ),
                          SizedBox(height: 10.h,),
                          TextFormField(
                            validator: (val) {
                              return val!.isEmpty || val.length < 2 ? "Try another Username" : null;
                            },
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration("Email"),

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
                                width: 200,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: textFieldInputDecoration("Phone Number"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          GestureDetector(
                            onTap: (){
                              print("Print");
                            },
                            child: Container(
                              child: Text("UPDATE",style: TextStyle(color: Colors.white),),
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
                          SizedBox(height: 20.h,),

                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),

          ],
        ),
      )
    );
  }
}
