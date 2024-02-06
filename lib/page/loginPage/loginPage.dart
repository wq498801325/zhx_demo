
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zhx_demo/components/appbar/custom_appbar.dart';
import 'package:zhx_demo/get/loginController.dart';

import 'package:zhx_demo/util/global.dart';



class LoginPage extends StatefulWidget {
  final Map? args;
  LoginPage({ this.args});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = Get.put(LoginController());
  var route;  //登陆成功后退回页面
  var routeparams;  //登陆成功后退回页面 参数
  String _autoCodeText = '获取验证码';
  bool _isLogin =false;
  String text = '';
  late Timer? _timer;
  int _timeCount = 60;
  bool _checkboxSelected=false;//维护复选框状态
  String _phoneNum = ''; //手机号
  bool _enable = true;


  //电话、验证码
  final TextEditingController _phoneNumController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  FocusNode _focusNodePhoneNum = FocusNode();
  FocusNode _focusNodeCode = FocusNode();

  //表单状态
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    if(widget.args!=null){
      route=widget.args!["route"];  //登陆成功后退回页面
      routeparams=widget.args!["routeparams"];  //登陆成功后退回页面 参数
    }
    super.initState();
  }


  /**
   * 验证手机号
   */
  String? validatePhoneNum(value) {
    // 正则匹配手机号
    RegExp exp = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    if (value.isEmpty) {
      setState(() {
        text = '手机号不能为空';
        _isLogin =false;
      });
    } else if (!G.isChinaPhoneLegal(value)) {
      setState(() {
        text = '手机号输入错误,请重新输入';
        _isLogin =false;
      });
    } else if (G.isChinaPhoneLegal(value)) {
      setState(() {
        text = '';
        _isLogin = true;
      });
    }
    return null;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          context: context, title: '', onBackTap: () {
        if(route==null){
          Get.back();
        }else{ //失效
          Get.toNamed(route,arguments:routeparams);
        }
      }),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 54.w, right: 54.w),
        child: ListView(
          children: [
            SizedBox(
              height: 140.h,
            ),
            _head(),
            SizedBox(
              height: 60.h,
            ),

            Container(
              height: 600.h,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: _inputWidget(),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      text,
                      style: TextStyle(
                          color: G.colorshex('#EE4014'), fontSize: 24.sp),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),

                  _loginButton(),

                  SizedBox(
                    height: 36.w,
                  ),
                  // _tab(),

                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  _more(),
                  SizedBox(
                    height: 40.h,
                  ),
                  _bottom(),
                  SizedBox(
                    height: 40.h,
                  ),
                ],
              ),
            ),
            /// 协议
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center ,
                children: <Widget>[
                  // G.user.getisShowBuyBtn()==1? Text("登录表示同意", style: TextStyle(fontSize: 24.sp, color: G.colorshex('#666666'))): ACheckBox(
                  Checkbox(
                    value: _checkboxSelected,
                    materialTapTargetSize:MaterialTapTargetSize.shrinkWrap,
                    onChanged: (bool? value) {
                      setState(() {
                        _checkboxSelected = value!;
                      });
                    },
                    activeColor: G.colorshex('#E2C471'),
                  ),
                  Text('我已阅读并同意', style: TextStyle(
                    color:G.colorshex("#666666"),
                    fontSize: 24.sp,
                  )),
                  InkWell(
                    child: Text('《隐私条款》', style: TextStyle(fontSize: 24.sp, color: G.colorshex('#BB8E13'))),
                    onTap: () => Get.toNamed('/privacy_policy',),
                  ),
                  InkWell(
                    child: Text('《用户协议》', style: TextStyle(fontSize: 24.sp, color: G.colorshex('#BB8E13'))),
                    onTap: () => Get.toNamed('/user_agreement',),
                  )
                ],),
            )
          ],
        ),
      ),
    );
  }

  Widget _head() {
    TextStyle _textStyle1 =
    TextStyle(fontSize: 28.sp, color: G.colorshex('#666666'));
    TextStyle _textStyle2 =
    TextStyle(fontSize: 28.sp, color: G.colorshex('#2D8CF0'));
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              '欢迎登录',
              style: TextStyle(
                  fontSize: 48.sp,
                  color: G.colorshex('#111111'),
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(text: '使用', style: _textStyle1),
                TextSpan(text: '手机号码', style: _textStyle2),
                // TextSpan(text: '或', style: _textStyle1),
                // TextSpan(text: '账号', style: _textStyle2),
                TextSpan(text: '登录注册', style: _textStyle1),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _tab() {
  //   return Container(
  //     child: InkWell(
  //       onTap: () {
  //         setState(() {
  //           _selectPhone = !_selectPhone;
  //           _selectNum = !_selectNum;
  //           text = '';
  //         });
  //       },
  //       child: Container(
  //         padding: EdgeInsets.only(bottom: 14.h),
  //         // decoration: BoxDecoration(
  //         //     border: Border(
  //         //         bottom: BorderSide(
  //         //   width: 3.h,
  //         //   color: _selectPhone ? G.colorshex('#E2C471') : Colors.white,
  //         // ))),
  //         child: Text(
  //           !_selectPhone?'短信验证码登录':'使用密码登录',
  //           style: TextStyle(
  //               fontSize: 24.sp,
  //               color:  G.colorshex('#555555')
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _inputWidget() {
    return Column(
      children: [
        Container(
          // padding: EdgeInsets.only(top: 17.h,bottom: 17.h),
          decoration: BoxDecoration(
              border:G.borderBottom(color: G.colorshex('#E2C471'))),
          width: 641.89.w,
          child:  Container(
              margin: EdgeInsets.only(left: 20.w),
              child: TextFormField(
                focusNode: _focusNodePhoneNum,
                controller: _phoneNumController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "请输入手机号码",
                    hintStyle: TextStyle(
                        fontSize: 28.sp,
                        color: G.colorshex('#BBBBBB')
                    )
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                //密码验证
                validator: validatePhoneNum,
                //保存数据
                onSaved: (String? value) {
                  _phoneNum = value!;
                },
              )),
        ),
        SizedBox(
          height: 30.h,
        ),
        Container(
          // padding: EdgeInsets.only(top: 17.h,bottom: 17.h),
            decoration: BoxDecoration(
                border:G.borderBottom(color: G.colorshex('#E2C471'))
            ),
            width: 641.89.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 400.w,
                    margin: EdgeInsets.only(left: 20.w),
                    child:TextField(
                      controller: _codeController,
                      focusNode: _focusNodeCode,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(6)
                      ],
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入验证码",
                          hintStyle: TextStyle(
                              fontSize: 28.sp,
                              color: G.colorshex('#BBBBBB')
                          )
                      ),
                      //保存数据
                    )
                ),
                InkWell(
                  onTap: (){
                    _enable==false?null:_getVerificationCode(_phoneNumController.text);
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Text(
                      _autoCodeText,style: TextStyle(
                        fontSize: 24.sp,
                        color: _enable==false?G.colorshex('#555555'):G.colorshex('#E2C471')
                    ),),
                  ),
                )

              ],
            )
        ),
      ],
    );
    //
    // else {
    //   return Column(
    //     children: [
    //       Container(
    //           decoration: BoxDecoration(
    //               border:G.borderBottom(color: G.colorshex('#E2C471'))),
    //           width: 641.89.w,
    //           padding: EdgeInsets.only(left: 20.w),
    //           child: TextFormField(
    //             focusNode: _focusNodeUserName,
    //             decoration: InputDecoration(
    //               border: InputBorder.none,
    //               hintText: "请输入账号",
    //               hintStyle: TextStyle(
    //                   fontSize: 28.sp,
    //                   color: G.colorshex('#BBBBBB')
    //               ),
    //             ),
    //             inputFormatters: [
    //               FilteringTextInputFormatter.digitsOnly,
    //             ],
    //             validator: validateUserName,
    //             onSaved: (String value) {
    //               _username = value;
    //             },
    //           )),
    //       SizedBox(
    //         height: 30.h,
    //       ),
    //       Container(
    //           decoration: BoxDecoration(
    //               border:G.borderBottom(color: G.colorshex('#E2C471'))),
    //           width: 641.89.w,
    //           padding: EdgeInsets.only(left: 20.w),
    //           child: TextFormField(
    //             focusNode: _focusNodePassWord,
    //             decoration: InputDecoration(
    //                 border: InputBorder.none,
    //                 hintText: "请输入密码",
    //                 hintStyle: TextStyle(
    //                     fontSize: 28.sp,
    //                     color: G.colorshex('#BBBBBB')
    //                 ),
    //                 suffixIcon: IconButton(
    //                   icon: _isShowPwd
    //                       ? iconEye(
    //                     color: (_isShowPwd)
    //                         ? Colors.black
    //                         : G.colorshex('#BBBBBB'),
    //                   )
    //                       : iconEyeClose(
    //                     color: (_isShowPwd)
    //                         ? Colors.black
    //                         : G.colorshex('#BBBBBB'),
    //                   ),
    //                   // 点击改变显示或隐藏密码
    //                   onPressed: () {
    //                     setState(() {
    //                       _isShowPwd = !_isShowPwd;
    //                     });
    //                   },
    //                 )),
    //             obscureText: !_isShowPwd,
    //             //密码验证
    //             validator: validatePassWord,
    //             //保存数据
    //             onSaved: (String value) {
    //               _password = value;
    //             },
    //           ))
    //     ],
    //   );
    // }
  }

  Widget _loginButton() {
    return InkWell(
      onTap: () {
        // if (G.user.isShowBuyBtn==0&&!_checkboxSelected){
        if (!_checkboxSelected){
          FocusScope.of(context).requestFocus(FocusNode());
          G.toast("请先勾选同意并隐私政策与用户条款");
          return;
        }
        _focusNodePhoneNum.unfocus();
        if (_formKey.currentState!.validate()) {
          //只有输入通过验证，才会执行这里
          _formKey.currentState!.save();
            _loginByPhoneNum();


        }
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
        width: 641.89.w,
        decoration: G.boxDecoration(100.w, color: G.colorshex('#E2C471')),
        child: Text(
          '登录',
          style: TextStyle(fontSize: 28.w, color: Colors.white),
        ),
      ),
    );
  }

  Widget _more() {
    return Container(
      alignment: Alignment.center,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Container(
              width: 200.w,
              child: Divider(
                color: G.colorshex('#D8D8D8'),
              ),
            ),
            // SizedBox(
            //   width: 37.w,
            // ),
            Container(
              child: Text(
                '更多登录方式',
                style:
                TextStyle(fontSize: 24.sp, color: G.colorshex('#888888')),
              ),
            ),
            // SizedBox(
            //   width: 37.w,
            // ),
            Container(
              width: 200.w,
              child: Divider(
                color: G.colorshex('#D8D8D8'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _bottom() {
    return Platform.isAndroid?Container(
      child:InkWell(
          onTap: (){
            _wxlogins();
          },
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.w,
                      color: G.colorshex('#BBBBBB'),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(100.w))),
                width: 100.w,
                height: 100.w,
                // padding: EdgeInsets.all(25.w),
                child: iconWeChart(size: 50.w, color: G.colorshex('#1ABE6B')),
              ),
              SizedBox(height: 20.h,),
              Text(
                '微信登录',
                style: TextStyle(
                    fontSize: 28.sp,
                    color: G.colorshex('#111111'),
                    fontWeight: FontWeight.w300),
              )
            ],
          )
      ),
    ):Container(
      margin: EdgeInsets.only(bottom: 40.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              _wxlogins();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: G.colorshex('#08C160'),
                  borderRadius: BorderRadius.all(Radius.circular(100.w))),
              width: 100.w,
              height: 100.w,
              // padding: EdgeInsets.all(25.w),
              child: iconWeChart(size: 50.w, color: G.colorshex('#FFFFFF')),
            ),
          ),
          SizedBox(
            width: 110.w,
          ),
          InkWell(
              onTap: (){
                _iphonelogins();
              },
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: G.colorshex('#000000'),
                        borderRadius: BorderRadius.all(Radius.circular(100.w))),
                    width: 100.w,
                    height: 100.w,
                    // padding: EdgeInsets.all(25.w),
                    child: iconApple(size: 50.w, color: G.colorshex('#FFFFFF')),
                  ),
                ],
              )
          )
        ],
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) => {
      setState(() {
        if(_timeCount <= 0){
          _enable = true;
          _autoCodeText = '重新获取';
          _timer!.cancel();
          _timer=null;
          _timeCount = 60;
        }else {
          _enable = false;
          _timeCount -= 1;
          _autoCodeText = '重新获取(${_timeCount}s)';
          return null;
        }
      })
    });
  }

  void _getVerificationCode(String phoneNum){
    if(G.isChinaPhoneLegal(phoneNum)){
      // var formDate={
      //   "phone": phoneNum,
      //   "code":Provider.of<FeedBackProvide>(context,listen: false).qwer,
      // };
      //
      // print("zcjphone "+phoneNum.toString());
      // print("zcjcode"+Provider.of<FeedBackProvide>(context,listen: false).qwer);
      // if(G.isChinaPhoneLegal(phoneNum)){
      //   request('getVerificationCode2',formData: formDate).then((value) {
      //     if(value!=null){
      //       print("zcj  value"+value.toString());
            _startTimer();
      //     }
      //   }
      //   );
      // }
    }else{
      print(phoneNum);
      G.toast('手机号输入错误，请重新输入');
    }
  }
//验证码登录
  void _loginByPhoneNum()async{}

}