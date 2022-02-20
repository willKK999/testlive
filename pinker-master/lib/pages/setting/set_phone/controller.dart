import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinker/lang/translation_service.dart';

import 'package:pinker/pages/application/my/library.dart';
import 'package:pinker/pages/setting/set_phone/library.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/widgets/widgets.dart';

class SetPhoneController extends GetxController {
  final state = SetPhoneState();

  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final MyController myController = Get.find();
  final String arguments = Get.arguments;

  /// 区号选择
  void handleGoCodeList() async {
    var result = await Get.toNamed(
      AppRoutes.codeList,
      arguments: state.code,
    );

    if (result != null) state.code = result;
  }

  /// 输入框文本监听
  void _textListener() {
    textController.addListener(() {
      if (state.code == '86' && !isChinaPhone(textController.text)) {
        state.isDissable = true;

        /// 输入框长度小于 7
      } else if (textController.text.length < 7) {
        state.isDissable = true;

        /// 手机注册 且 输入的不是纯数字
      } else if (!textController.text.isNum) {
        state.isDissable = true;

        /// 其他
      } else {
        state.isDissable = false;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    focusNode.requestFocus();
    _textListener();
  }

  void handleNext() async {
    focusNode.unfocus();

    /// 下一步按钮，点击事件
    getDialog(
      child: DialogChild.alert(
        onPressedLeft: _edit,
        onPressedRight: _sure,
        title: Lang.registerVerifyPhone.tr,
        content: Lang.registerDialogPhone_1.tr +
            getLastTwo(textController.text) +
            Lang.registerDialogPhone_2.tr,
      ),
      autoBack: true,
    );
  }

  void _edit() {
    Get.back();
  }

  void _sure() async {
    Get.back();
    Map<String, dynamic> data = {
      'account': textController.text,
      'areaCode': state.code,
      'password': arguments,
      'entryType': '1',
      'accountType': '1',
    };
    Get.toNamed(
      AppRoutes.set + AppRoutes.checkPassword + AppRoutes.setVerify,
      arguments: data,
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    textController.dispose();
    super.dispose();
  }
}
