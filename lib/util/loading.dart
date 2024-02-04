
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zhx_demo/util/global.dart';


class Loading {

  show(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        return SafeArea(
          child: Builder(
            builder: (BuildContext context) {
              return Center(
                child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10.w),
                   color: Colors.black54,
                 ),
                 width: 150.w,
                 height: 170.h,
                 child: Container(
                   alignment: Alignment.center,
                   width: 100.w,
                   height: 105.h,
                   child:Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       CircularProgressIndicator(backgroundColor: Colors.black54,valueColor: AlwaysStoppedAnimation(Colors.white),),
                       SizedBox(height: 10.h,),
                       Container(
                         alignment: Alignment.center,
                         child: Text('加载中',style: TextStyle(color:Colors.white,fontSize: 20.sp ),),
                       )
                     ],
                   )
                 ),
                ),
              );
            }
          ),
        );
      },
      barrierDismissible: false,///是否点击旁边取消
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      // barrierColor: rgba(255,255,255,0),
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: child,
        );
      },
    );
  }

  hide(BuildContext? context) {
      // G.Canpop();
    Get.back();
  }
}



// import 'package:bot_toast/bot_toast.dart';
// import 'package:color_dart/color_dart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:kdlzouz/utils/global.dart';
// import 'package:shimmer/shimmer.dart';
//
//
// class Loading {
//   show(BuildContext contexts) {
//     BotToast.showCustomLoading(clickClose:true,toastBuilder: (contexts) {
//       return  Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.w),
//           color: Colors.black54,
//         ),
//         width: 150.w,
//         height: 170.h,
//         child: Container(
//             alignment: Alignment.center,
//             width: 100.w,
//             height: 105.h,
//             child:Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CircularProgressIndicator(backgroundColor: Colors.black54,valueColor: AlwaysStoppedAnimation(Colors.white),),
//                 SizedBox(height: 10.h,),
//                 Container(
//                   alignment: Alignment.center,
//                   child: Text('数据加载中',style: TextStyle(color:Colors.white,fontSize: 18.sp ),),
//                 )
//               ],
//             )
//         ),
//       );
//     });
//   }
//
//   hide(BuildContext context) {
//     BotToast.closeAllLoading();
//   }
// }
