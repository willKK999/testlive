import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pinker/pages/fogot/library.dart';
import 'package:pinker/routes/app_pages.dart';

import 'package:pinker/values/colors.dart';
import 'package:pinker/values/values.dart';
import 'package:pinker/widgets/widgets.dart';

class ForgotView extends StatelessWidget {
  const ForgotView({Key? key, this.arguments}) : super(key: key);
  final Map<String, dynamic>? arguments;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotController>(
        init: ForgotController(arguments),
        builder: (controller) {
          /// appbar
          AppBar appBar = getAppBar(
            getSpan('找回密码', fontSize: 17),
            backgroundColor: AppColors.mainBacground,
            leading: getButton(
              child: const Icon(Icons.close, color: AppColors.mainIcon),
              background: AppColors.mainBacground,
              onPressed: controller.handleBack,
            ),
          );

          /// body布局
          Widget body = Column(
            children: [
              Container(height: 15.h, color: AppColors.mainBacground),
              appBar,
              Container(height: 1.h, color: AppColors.secondBacground),
              Expanded(
                child: Container(
                  color: AppColors.mainBacground,
                  child: Navigator(
                    key: Get.nestedKey(3),
                    initialRoute: arguments == null
                        ? AppRoutes.forgotIndex
                        : AppRoutes.forgotType,
                    onGenerateRoute: controller.onGenerateRoute,
                  ),
                ),
              ),
            ],
          );
          return body;
        });
  }
}
