
import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../config/routes/routes_name.dart';

class SplashServices{
  void isLogin(BuildContext context){
    Timer(const Duration(seconds: 3),
            () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.homeScreen, (route)=> false)
    );
  }
}