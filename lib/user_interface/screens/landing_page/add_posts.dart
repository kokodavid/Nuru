import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:nuru/databases/posts_db.dart';
import 'package:nuru/helpers/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPostsScreen extends StatefulWidget {
  @override
  _AddPostsScreenState createState() => _AddPostsScreenState();
}

class _AddPostsScreenState extends State<AddPostsScreen> {
  List<String> _values = [];
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  _onDelete(index) {
    setState(() {
      _values.removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
        child: Container(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 19),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          // Navigator.pop(context);
                        },
                        child: Text(
                          "Close",
                          style: TextStyle(
                              color: kBlack,
                              fontWeight: FontWeight.normal,
                              fontSize: 18),
                        ),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      GestureDetector(
                        onTap: (){

                             // insertPosts(post);
                             print("taps");
                        },
                        child: Text(
                          "Post",
                          style: TextStyle(
                              color: kYellow,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: Container(
                    height: 250.h,
                    child: TextFormField(
                      maxLines: 25,
                      maxLength: 300,
                      decoration: textFieldInputDecoration(
                          "What do you want to talk about ?"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                      child: Text(
                      "Add Tags",
                  style: TextStyle(
                        color: kYellow,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                ),
                    )),
                SizedBox(
                  height: 5.h,
                ),
                KeyboardAvoider(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    child: Container(
                      child: TagEditor(
                          length: _values.length,
                          delimiters: [',', ' '],
                          hasAddButton: true,
                         inputDecoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Add Tags...',
                        ),
                        onTagChanged: (newValue) {
                          setState(() {
                            _values.add(newValue);
                          });
                        },
                        tagBuilder: (context, index) => _Chip(
                          index: index,
                          label: _values[index],
                          onDeleted: _onDelete,
                        ),
                      )
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                      child: Text(
                        "Add Media",
                        style: TextStyle(
                            color: kYellow,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                    )),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: ()async{
                      FilePickerResult result = await FilePicker.platform.pickFiles();

                      if(result != null) {
                        File file = File(result.files.single.path);
                      } else {
                        // User canceled the picker
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.photo_camera_sharp),
                        Icon(Icons.videocam),
                        Icon(Icons.photo),
                        Icon(Icons.attachment),
                      ],
                    ),
                  ),
                )
              ],
            ),
        ),
      ),
          )),
    );
  }

}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}