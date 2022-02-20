import 'package:get/get.dart';
import 'package:pinker/global.dart';
import 'package:pinker/routes/app_pages.dart';
import 'package:pinker/utils/utils.dart';
import 'package:pinker/values/values.dart';

/// 检查是否有 token
Future<bool> isAuthenticated() async {
  var profileJSON = StorageUtil().getJSON(storageUserTokenKey);
  return profileJSON != null ? true : false;
}

/// 删除缓存 token
Future deleteAuthentication() async {
  await StorageUtil().remove(storageUserTokenKey);
  await StorageUtil().remove(storageUserInfoKey);

  Global.token = null;
  Global.isOfflineLogin = false;
}

/// 重新登录
Future goLoginPage() async {
  await deleteAuthentication();
  Get.offAllNamed(AppRoutes.frame);
}
