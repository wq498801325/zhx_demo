import 'package:flutter/material.dart';
import 'package:zhx_demo/util/global.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavigationIndex = 0;  //底部导航的索引

  final pages = [
    Container(), //首页
    Container(), //发现页
    Container(), //商城页
    Container()  //个人主页
  ];





//底部导航-图标和文字定义
  List<BottomNavigationBarItem> items(){
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: '首页',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.find_in_page),
        label: '发现',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.message),
        label: '消息',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.local_activity),
        label: '我的',
      ),
    ];
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_bottomNavigationIndex], //页面切换
        bottomNavigationBar: _bottomNavigationBar()  //底部导航
    );
  }

  //底部导航-样式
  BottomNavigationBar _bottomNavigationBar(){
    return BottomNavigationBar(
      items: items(), //底部导航-图标和文字的定义，封装到函数里
      currentIndex: _bottomNavigationIndex,
      onTap: (flag) {
        setState(() {
          _bottomNavigationIndex = flag;  //使用底部导航索引
        });
      }, //onTap 点击切换页面
      fixedColor: Colors.blue,  //样式：图标选中时的颜色：蓝色
      type: BottomNavigationBarType.fixed, //样式：选中图标后的样式是固定的
    );
  }




}

