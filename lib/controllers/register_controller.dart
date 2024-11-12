import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haftsara_blog/components/storage_const.dart';
import 'package:haftsara_blog/components/url_api_constant.dart';
import 'package:haftsara_blog/gen/assets.gen.dart';
import 'package:haftsara_blog/services/dio_service.dart';
import 'package:haftsara_blog/view/home_screen.dart';
import 'package:haftsara_blog/view/users/register_screen.dart';
import 'package:haftsara_blog/view/users/route_write_bottom_modal_sheet_screen.dart';

class RegisterController extends GetxController {
  TextEditingController eamilTextEditingCortroller = TextEditingController();
  TextEditingController activatedCodeEditingCortroller =
      TextEditingController();
  String url = '${UrlApiConstant.mainUrl}/Techblog/api/register/action.php';
  var email = '';
  var userId = '';

  register() async {
    Map<String, dynamic> map = {
      'email': eamilTextEditingCortroller.text,
      'command': 'register'
    };
    var response = await DioService().postMethod(map, url);
    if (response.statusCode == 200) {
      email = eamilTextEditingCortroller.text;
      userId = response.data['user_id'];
    }
  }

  verify() async {
    Map<String, dynamic> map = {
      'email': email,
      'user_id': userId,
      'code': activatedCodeEditingCortroller.text,
      'command': 'verify'
    };
    log(map.toString());
    var response = await DioService().postMethod(map, url);
    //  debugPrint(response.data);
    var status = response.data['response'];
    switch (status) {
      case 'verified':
        var box = GetStorage();
        box.write(StorageConst.token, response.data['token']);
        box.write(StorageConst.userId, response.data['user_id']);
        Get.offAll(() => const HomeScreen());
        break;
      case 'incorrect_code':
        Get.snackbar('خطا', 'کد وارد شده صحیح نیست');
        break;
      case 'expired':
        Get.snackbar('خطا', 'کد وارد شده منقضی شده است!');
        break;
    }
  }

  checkLogin() {
    if (GetStorage().read(StorageConst.token) == null) {
      Get.to(() => RegisterScreen());
    } else {
      routeWriteBottomModalSheetScreen();
    }
  }

  
}
