import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinker/global.dart';
import 'package:pinker/pages/application/library.dart';

import 'package:pinker/pages/frame/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class FrameView extends GetView<FrameController> {
  const FrameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// logo
    Widget logo = Icon(
      IconFont.logo,
      size: 20.w,
      color: AppColors.mainColor,
    );

    /// appBar 两侧的占位
    Widget emptyBox = const SizedBox();

    /// appBar 左侧的返回按钮
    Widget buttonBox = getButton(
      child: SvgPicture.asset('assets/svg/icon_back.svg'),
      onPressed: controller.handleBack,
      background: Colors.transparent,
      width: 30.w,
      height: 30.w,
    );

    /// appBar 右侧的设置按钮
    Widget settingBox = getButton(
      child: SvgPicture.asset('assets/svg/icon_setting.svg'),
      onPressed: controller.handleGoSettingView,
      background: Colors.transparent,
      width: 30.w,
      height: 30.w,
    );

    /// appBar
    AppBar appBar = getAppBar(
      logo,
      leading: Obx(() => controller.state.pageIndex > 0 ? buttonBox : emptyBox),
      actions: [settingBox],
    );

    /// body 嵌套路由
    Widget body = Navigator(
      key: Get.nestedKey(1),
      initialRoute: AppRoutes.index,
      onGenerateRoute: controller.onGenerateRoute,
    );

    return Global.isOfflineLogin
        ? const ApplicationView()
        : Scaffold(
            backgroundColor: AppColors.mainBacground,
            appBar: appBar,
            body: body,
          );
  }
}
