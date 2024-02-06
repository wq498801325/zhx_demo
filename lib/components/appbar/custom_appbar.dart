
import 'package:flutter/material.dart';
import 'package:zhx_demo/util/global.dart';


/// 通用appbar
/// 
/// ```
/// @param {BuildContext} - context 如果context存在：左边有返回按钮，反之没有
/// @param {String} title - 标题
/// @param {bool} borderBottom - 是否显示底部border
/// ```
AppBar customAppbar({
  BuildContext? context,
  String title = '',
  String color ='fff',
  Function? onBackTap ,
  bool borderBottom = false,
  List<Widget>? actions
}) {

  return AppBar(
    centerTitle: true,
    title: Text(title,style: TextStyle(
        color:Colors.black, fontSize: 36.sp,fontWeight: FontWeight.w600
    ),),
    backgroundColor:  G.colorshex(color),
    elevation:0,
    leading: context == null ? null : InkWell(
      child: Container(
        width: 50.w,
        child: iconLeft(color: Colors.black, size: 40.sp),
      ),
      onTap:(){
        onBackTap??Get.back();
      },
    ),
    bottom: PreferredSize(
      child: Container(
        decoration: BoxDecoration(
          border: G.borderBottom(show: borderBottom)
        ),
      ),
      preferredSize: Size.fromHeight(0),
    ),
    actions: actions,
  );
}