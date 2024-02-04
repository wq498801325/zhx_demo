import 'package:flutter/material.dart';
import 'package:zhx_demo/main.dart';
import 'package:zhx_demo/page/homePage.dart';


class Router {
  static final _routes = {
    '/home_page': (BuildContext context, {args}) =>HomePage (),///研发档案
  };
}
