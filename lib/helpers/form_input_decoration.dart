import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nuru/helpers/constant.dart';


InputDecoration formInputDecoration({
  required String hintText,
  required IconData prefixIcon,
  required bool isDense,
}) {
  return InputDecoration(
    hintText: hintText,
    alignLabelWithHint: true,
    isDense: isDense,
    enabled: true,
    fillColor: Colors.black12,
    filled: true,
    hintStyle: hintStyle.copyWith(color: Colors.white),
    labelStyle: labelStyle.copyWith(color: Colors.white),
    prefixIcon: Icon(
      prefixIcon,
      color: Colors.white60,
      size: 25.r,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.circular(20.r),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.circular(20.r),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.circular(24.r),
    ),
  );
}