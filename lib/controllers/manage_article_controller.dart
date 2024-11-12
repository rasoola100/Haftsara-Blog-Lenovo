import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haftsara_blog/components/storage_const.dart';
import 'package:haftsara_blog/components/url_api_constant.dart';
import 'package:haftsara_blog/controllers/file_controller.dart';
import 'package:haftsara_blog/gen/assets.gen.dart';
import 'package:haftsara_blog/model/article_model.dart';
import 'package:haftsara_blog/model/article_single_model.dart';
import 'package:haftsara_blog/services/dio_service.dart';
import 'package:dio/dio.dart' as dio;

class ManageArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList.empty();
  RxBool loading = false.obs;
  // RxList<ArticleSingleModel> articleSignleList = RxList();
  Rx<ArticleSingleModel> articleSingleModel = ArticleSingleModel().obs;
  TextEditingController titleTextEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    getManageArticle();
  }

  getManageArticle() async {
    loading.value = true;
    var response = await DioService().getMethod(
        UrlApiConstant.getArticlePublishedMe +
            GetStorage().read(StorageConst.userId));
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = false;
    }
  }

  updateTitle() {
    articleSingleModel.update((fn) {
      fn!.title = titleTextEditingController.text;
    });
  }

  storeArticle() async {
    String url =
        "https://techblog.sasansafari.com/Techblog/api/article/post.php";
    // FileController fileController = Get.find<FileController>();
    loading.value = true;
    Map<String, dynamic> map = {
      'title': articleSingleModel.value.title,
      'content': articleSingleModel.value.content,
      'cat_id': articleSingleModel.value.catId,
      'user_id': GetStorage().read(StorageConst.userId),
      'tag_list': '[]',
      // 'image': await dio.MultipartFile.fromFile(fileController.file.value.path!),
      'image': 'image',
      'command': 'store'
    };
    var response = await DioService().postMethod(map, url);
    
      // Get.back();
    
    log(response.data);
    loading.value = false;
  }
}
