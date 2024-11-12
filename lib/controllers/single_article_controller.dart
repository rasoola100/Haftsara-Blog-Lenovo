import 'package:get/get.dart';
import 'package:haftsara_blog/components/url_api_constant.dart';
import 'package:haftsara_blog/model/article_model.dart';
import 'package:haftsara_blog/model/article_single_model.dart';
import 'package:haftsara_blog/model/category_model.dart';
import 'package:haftsara_blog/services/dio_service.dart';

class SingleArticleController extends GetxController {
  // RxString id = RxString('-1');
  Rx<ArticleSingleModel> articleSingleModel = ArticleSingleModel().obs;
  RxBool loading = false.obs;
  RxList<CategoryModel> categoryList = RxList();
  RxList<ArticleModel> relatedArticleList = RxList();

  // @override
  // void onInit() {
  //   super.onInit();
  //   getArticleInfo();
  // }

  getArticleInfo(var id) async {
    articleSingleModel = ArticleSingleModel().obs;
    loading.value = true;
    var response = await DioService().getMethod(
        '${UrlApiConstant.baseUrl}article/get.php?command=info&id=$id&user_id=1');
        if(response.statusCode == 200) {
          articleSingleModel.value = ArticleSingleModel.fromJson(response.data);

          categoryList.clear();
          response.data['tags'].forEach((element) {
            categoryList.add(CategoryModel.fromJson(element));
          });

          relatedArticleList.clear();
          response.data['related'].forEach((element) {
            relatedArticleList.add(ArticleModel.fromJson(element));
          });

    
          loading.value = true;
        }
        
  }
}
