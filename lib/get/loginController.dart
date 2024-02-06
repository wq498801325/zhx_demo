import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluwx/fluwx.dart' as fluwx;


class LoginController extends GetxController {
  Timer? _timer;
  RxBool isCodeSent = false.obs;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (timer.tick == 60) {
          isCodeSent.value = false;
          timer.cancel();
        }
      },
    );
  }

  Future<void> signInWithWeChat() async {
    // await fluwx.sendWeChatAuth(
    //   scope: "snsapi_userinfo",
    //   state: "wechat_sdk_demo_test",
    // );
  }

  Future<void> signInWithPhone() async {
    // 处理手机号登录逻辑
    String phoneNumber = phoneController.text;
    String verificationCode = codeController.text;

    // 使用 phoneNumber 和 verificationCode 进行登录验证
    // ...

    // 登录成功后的处理
  }

  Future<void> sendVerificationCode() async {
    // 处理发送验证码逻辑
    String phoneNumber = phoneController.text;

    // 发送验证码的逻辑
    // ...

    // 假设发送成功后开始计时
    isCodeSent.value = true;
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

