import 'package:flutter/material.dart';

import 'app_color.dart';

InputDecoration inputDecoration(String hintText){
  return InputDecoration(
    labelStyle: TextStyle(color: Colors.black54),
    label: Text(hintText),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide(color: AppColor.inputBorderColor)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),),
    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),),
    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),),
  );
}