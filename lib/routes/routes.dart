import 'package:flutter/material.dart';
import 'package:zhx_demo/main.dart';
import 'package:zhx_demo/page/homePage.dart';
import 'package:zhx_demo/page/loginPage/loginPage.dart';


class Router {
  static final _routes = {
    '/home_page': (BuildContext context, {args}) =>HomePage (),///主页
    '/login_page': (BuildContext context, {args}) =>LoginPage (),///主页
  };
}
