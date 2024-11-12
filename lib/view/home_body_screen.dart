import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haftsara_blog/components/colors_blog.dart';
import 'package:haftsara_blog/route_manager/route_name.dart';
import 'package:haftsara_blog/controllers/article_controller.dart';
import 'package:haftsara_blog/controllers/home_controller.dart';
import 'package:haftsara_blog/controllers/single_article_controller.dart';
import 'package:haftsara_blog/gen/assets.gen.dart';
import 'package:haftsara_blog/model/fake_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:haftsara_blog/view/articles/article_list_screen.dart';
import 'package:haftsara_blog/view/articles/article_single_screen.dart';
import 'package:haftsara_blog/view/podcasts/podcast_list_screen.dart';

class HomeBodyScreen extends StatelessWidget {
  HomeBodyScreen({
    super.key,
    required this.screenSize,
    required this.textTheme,
  });

  final Size screenSize;
  final TextTheme textTheme;

  final HomeController homeController = Get.put(HomeController());
  final SingleArticleController singleArticleController =
      Get.put(SingleArticleController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
        child: Column(
          children: [
            // poster-----------------------------------------
            const SizedBox(
              height: 10,
            ),
            homePagePoster(),
            // category list--------------------------------
            const SizedBox(
              height: 20,
            ),
            homePageCategoryList(),

            // top articles--------------------------------------
            const SizedBox(
              height: 18,
            ),
            InkWell(
              onTap: () {
                Get.to(ArticleListScreen(title: 'فهرست مقالات'));
              },
              child: Row(
                children: [
                  ImageIcon(
                    Assets.icons.pen.provider(),
                    color: ColorsBlog.primaryColor,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    'مطالب داغ',
                    style: textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            homePageTopArticlesList(),

            // top podcast--------------------------------------------
            const SizedBox(height: 1),
            InkWell(
              onTap: () => Get.toNamed(RouteName.routePodcastListScreen),
              child: Row(
                children: [
                  ImageIcon(
                    Assets.icons.podcast.provider(),
                    color: ColorsBlog.primaryColor,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    'پادکست‌های داغ',
                    style: textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            homePageTopPodcastList(),

            const SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
    );
  }

  Widget homePageTopPodcastList() {
    return SizedBox(
      height: screenSize.width < 480
          ? screenSize.height / 3.6
          : screenSize.height / 1.9,
      child: Obx(
        () => ListView.builder(
          itemCount: homeController.podcastList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(RouteName.routePodcastSingleScreen,
                    arguments: homeController.podcastList[index]);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenSize.width < 480
                          ? screenSize.height / 6
                          : screenSize.height / 3.2,
                      width: screenSize.width < 480
                          ? screenSize.height / 4
                          : screenSize.height / 1.7,
                      child: CachedNetworkImage(
                        imageUrl: homeController.podcastList[index].poster!,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(2, 2),
                                    blurRadius: 3)
                              ],
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.fill),
                            ),
                          );
                        },
                        placeholder: (context, url) => const SpinKitFadingCube(
                          size: 40,
                          color: Colors.grey,
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.image_not_supported_outlined,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    SizedBox(
                      width: screenSize.height / 6,
                      child: Text(
                        homeController.podcastList[index].title!,
                        style: textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget homePageTopArticlesList() {
    return SizedBox(
      height: screenSize.width < 480
          ? screenSize.height / 3.4
          : screenSize.height / 1.9,
      width: double.infinity,
      child: Obx(
        () => ListView.builder(
          itemCount: homeController.articleList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                var id = homeController.articleList[index].id;
                // Get.find<SingleArticleController>().getArticleInfo(id);
                singleArticleController.getArticleInfo(id);
                Get.to(() => ArticleSingleScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: screenSize.width < 480
                              ? screenSize.height / 6
                              : screenSize.height / 3.2,
                          width: screenSize.width < 480
                              ? screenSize.height / 4
                              : screenSize.height / 1.7,
                          child: CachedNetworkImage(
                            imageUrl: homeController.articleList[index].image!,
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: imageProvider, fit: BoxFit.fill),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 3,
                                          offset: Offset(1, 1))
                                    ]),
                                foregroundDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: const LinearGradient(
                                      colors: ColorsBlog.articleGradientColor,
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                ),
                              );
                            },
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(
                              color: Colors.grey,
                            ),
                            errorWidget: (context, url, error) => Image(
                              image: Assets.images.linux.provider(),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          right: 10,
                          bottom: 8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                homeController.articleList[index].author!,
                                style: textTheme.labelSmall,
                              ),
                              Row(
                                children: [
                                  Text(
                                    homeController.articleList[index].view!,
                                    style: textTheme.labelSmall,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  const Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    SizedBox(
                      width: screenSize.height / 4,
                      child: Text(
                        homeController.articleList[index].title!,
                        style: textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget homePageCategoryList() {
    return SizedBox(
      height: 60,
      child: Obx(
        () => ListView.builder(
          itemCount: homeController.categoryList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.find<ArticleController>().getArticleLisByCatId(
                    homeController.categoryList[index].id!);
                Get.to(() => ArticleListScreen(
                    title: homeController.categoryList[index].title!));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                          colors: ColorsBlog.categoryGradientColor,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        ImageIcon(
                          Assets.icons.hashtag.provider(),
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          homeController.categoryList[index].title!,
                          style: textTheme.labelMedium,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget homePagePoster() {
    return Obx(
      () => homeController.loading.value == true
          ? const CircularProgressIndicator(
              color: Colors.grey,
            )
          : GestureDetector(
              onTap: () {
                var id = homeController.poster.value.id;
                // Get.find<SingleArticleController>().getArticleInfo(id);
                singleArticleController.getArticleInfo(id);
                Get.to(() => ArticleSingleScreen());
              },
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: screenSize.width < 480
                        ? screenSize.height / 3
                        : screenSize.height / 2,
                    child: CachedNetworkImage(
                      imageUrl: homeController.poster.value.image!,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.fill)),
                          foregroundDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                  colors: ColorsBlog.posterGradientColor,
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                        );
                      },
                      placeholder: (context, url) => const SpinKitFadingCube(
                        size: 50,
                        color: Colors.grey,
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.image_not_supported,
                        size: 80,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 10,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 1, 12, 0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                homePosterMap['author'] +
                                    ' ' +
                                    homePosterMap['date'],
                                style: textTheme.labelSmall,
                              ),
                              Text(
                                homePosterMap['view'] + ' بازدید',
                                style: textTheme.labelSmall,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            homeController.poster.value.title!,
                            style: textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
