import 'package:get/get.dart';
import 'package:haftsara_blog/components/url_api_constant.dart';
import 'package:haftsara_blog/model/article_model.dart';
import 'package:haftsara_blog/model/category_model.dart';
import 'package:haftsara_blog/model/podcast_model.dart';
import 'package:haftsara_blog/model/poster_model.dart';
import 'package:haftsara_blog/services/dio_service.dart';


class HomeController extends GetxController {
  Rx<PosterModel> poster = PosterModel().obs;
  RxList<CategoryModel> categoryList = RxList();
  RxList<ArticleModel> articleList = RxList();
  RxList<PodcastModel> podcastList = RxList();
  RxBool loading = false.obs;

  @override
  onInit() {
    super.onInit();
    getHomeItems();
  }

  getHomeItems() async {
    loading.value = true;
    var response = await DioService().getMethod(UrlApiConstant.getHomeItems);
    if (response.statusCode == 200) {
      response.data['top_visited'].forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });

      response.data['top_podcasts'].forEach((element) {
        podcastList.add(PodcastModel.fromJson(element));
      });

      response.data['categories'].forEach((element) {
        categoryList.add(CategoryModel.fromJson(element));
      });

      poster.value = PosterModel.fromJson(response.data['poster']);

      loading.value = false;
    }
  }
}
