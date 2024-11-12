import 'package:get/get.dart';
import 'package:haftsara_blog/components/url_api_constant.dart';
import 'package:haftsara_blog/model/article_model.dart';
import 'package:haftsara_blog/services/dio_service.dart';

class ArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList();
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  getList() async {
    loading.value = true;
    var response = await DioService().getMethod(UrlApiConstant.getArticleList);
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = false;
    }
  }

  getArticleLisByCatId(String id) async {
    articleList.clear();
    loading.value = false;
    var userId = '';
    var response = await DioService().getMethod(
        '${UrlApiConstant.baseUrl}article/get.php?command=get_articles_with_tag_id&tag_id=$id&user_id=$userId');
        if(response.statusCode == 200) {
          response.data.forEach((element) {
            articleList.add(ArticleModel.fromJson(element));
          });
          loading.value = false;
        }
  }
}
