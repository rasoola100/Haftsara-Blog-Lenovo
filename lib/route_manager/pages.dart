import 'package:get/get.dart';
import 'package:haftsara_blog/route_manager/binding.dart';
import 'package:haftsara_blog/route_manager/route_name.dart';
import 'package:haftsara_blog/view/articles/article_manage_screen.dart';
import 'package:haftsara_blog/view/articles/article_single_screen.dart';
import 'package:haftsara_blog/view/articles/single_manage_article_screen.dart';
import 'package:haftsara_blog/view/home_screen.dart';
import 'package:haftsara_blog/view/podcasts/podcast_list_screen.dart';
import 'package:haftsara_blog/view/podcasts/podcast_single_screen.dart';
import 'package:haftsara_blog/view/splash_screen.dart';

class Pages {
  Pages._();
  static List<GetPage> pages = [
    GetPage(
        name: RouteName.routeInitialRoute, 
        page: () => const SplashScreen()),
    GetPage(
        name: RouteName.routeHomeScreen,
        page: () => const HomeScreen(),
        binding: RegisterBinding()),
    GetPage(
        name: RouteName.routeSingleArticleScreen,
        page: () => ArticleSingleScreen(),
        binding: ArticleBinding()),
    GetPage(
        name: RouteName.routeMangeArticleScreen,
        page: () => ArticleManageScreen(),
        binding: ArticleManageBinding()),
    GetPage(
        name: RouteName.routeSingleManageArticleScreen,
        page: () => SingleManageArticleScreen(),
        binding: SingleManageArticleBinding()),
    GetPage(
        name: RouteName.routePodcastListScreen,
        page: () => PodcastListScreen(),
        binding: PodcastBinding()),
    GetPage(
        name: RouteName.routePodcastSingleScreen,
        page: () => PodcastSingleScreen()),
  ];
}
