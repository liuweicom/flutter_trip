import 'package:flutter/material.dart';
class NavigatorUtil{
  static push(BuildContext context, page){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return page;
    }));
  }
}
