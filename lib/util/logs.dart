
import 'package:flutter/cupertino.dart';

class Logs {  //dart.vm.product 环境标识位 Release为true debug 为false
  // static const bool isRelease = const bool.fromEnvironment("dart.vm.product");
  static const bool isRelease = true ;  //是否打印LOG
      static void d(Object message) {
    if (isRelease) print(message);
  }

  static void e(String tag, Object message, {Exception? e}) {
    // print(message);
  }

}