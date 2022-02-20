import 'package:get/get.dart';

class VerifyState {
  /// 焦点透明度
  final RxDouble _opacity = 1.0.obs;
  set opacity(double value) => _opacity.value = value;
  double get opacity => _opacity.value;

  /// 验证码数组
  final RxList _codeList = [].obs;
  set codeList(List value) => _codeList.value = value;
  List get codeList => _codeList;
}
