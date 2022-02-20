import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pinker/lang/translation_service.dart';
import 'package:pinker/pages/frame/index/library.dart';

import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 标题
    Widget text = getSpan(
      Lang.indexTitle.tr,
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    );

    /// 去注册页面的按钮
    Widget signUpButton = getButton(
      padding: EdgeInsets.only(top: 7.h, bottom: 7.h),
      onPressed: controller.handleGoSignUpPage,
      child: getSpan(Lang.indexGoRegister.tr),
      width: double.infinity,
    );

    /// 去登陆页面的按钮
    Widget signInbutton = SizedBox(
      width: double.infinity,
      child: RichText(
        text: TextSpan(
          text: Lang.indexHint.tr,
          style: const TextStyle(color: AppColors.secondText, fontSize: 15),
          children: [
            TextSpan(
              text: Lang.indexGoLogin.tr,
              style: const TextStyle(color: AppColors.mainColor, fontSize: 15),
              recognizer: TapGestureRecognizer()
                ..onTap = controller.handleGoSignInPage,
            ),
          ],
        ),
      ),
    );

    /// body 布局
    Widget body = Padding(
      padding: EdgeInsets.only(
        right: 20.w,
        bottom: 30.h,
        left: 20.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(),
          Column(
            children: [
              text,
              SizedBox(height: 10.h),
              signUpButton,
            ],
          ),
          signInbutton,
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(
        () => controller.frameController.state.pageIndex != 0
            ? Stack(
                // 遮罩层
                children: [
                  body,
                  Container(
                    color: Colors.black12,
                  )
                ],
              )
            : body,
      ),
    );
  }
}
