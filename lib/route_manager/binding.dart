import 'package:get/get.dart';
import 'package:haftsara_blog/controllers/article_controller.dart';
import 'package:haftsara_blog/controllers/manage_article_controller.dart';
import 'package:haftsara_blog/controllers/podcast_controller.dart';
import 'package:haftsara_blog/controllers/register_controller.dart';
import 'package:haftsara_blog/controllers/single_article_controller.dart';

class ArticleBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(ArticleController(), permanent: false);
    Get.put(() => ArticleController(), permanent: false);
    Get.lazyPut(() => SingleArticleController());
  }
}


class ArticleManageBinding extends Bindings {
  @override  
  void dependencies() {
    Get.put(() => ManageArticleController());
  }
}

class SingleManageArticleBinding extends Bindings {
  @override  
  void dependencies() {
    Get.lazyPut(() => ManageArticleController());
  }
}

class RegisterBinding extends Bindings {
  @override 
  void dependencies() {
    Get.put(RegisterController());
  }
}

class PodcastBinding extends Bindings {
  @override  
  void dependencies() {
    Get.put(() => PodcastController());
  }
}


