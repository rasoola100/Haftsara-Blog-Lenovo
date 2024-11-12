import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:haftsara_blog/components/colors_blog.dart';
import 'package:haftsara_blog/controllers/article_controller.dart';
import 'package:haftsara_blog/controllers/single_article_controller.dart';
import 'package:haftsara_blog/gen/assets.gen.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:haftsara_blog/view/articles/article_list_screen.dart';

class ArticleSingleScreen extends StatelessWidget {
  ArticleSingleScreen({super.key});

  // final SingleArticleController singleArticleController =
  //     Get.put(SingleArticleController());
  final dynamic singleArticleController = Get.find<SingleArticleController>();

  // @override
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(
            () => singleArticleController.articleSingleModel.value.id == null
                ? SizedBox(
                    height: Get.height,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: screenSize.width < 420
                                  ? screenSize.height / 3
                                  : screenSize.height / 1.5,
                              width: double.infinity,
                              child: CachedNetworkImage(
                                imageUrl: singleArticleController
                                    .articleSingleModel.value.image!,
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover)),
                                  );
                                },
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(
                                  color: Colors.grey,
                                ),
                                errorWidget: (context, url, error) => Image(
                                  image: Assets.images.linux.provider(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 60,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: ColorsBlog
                                            .articleSingleAppBarGradientColor,
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: const Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                          size: 33,
                                        ),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      const Icon(
                                        Icons.bookmark_border,
                                        color: Colors.white,
                                        size: 33,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      const Icon(
                                        Icons.share,
                                        color: Colors.white,
                                        size: 33,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            singleArticleController
                                .articleSingleModel.value.title!,
                            style: textTheme.titleSmall,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CircleAvatar(
                                    radius: 25,
                                    child: Image(
                                      image: Assets.images.avatar.provider(),
                                    ),
                                  )),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                singleArticleController
                                    .articleSingleModel.value.author!,
                                style: textTheme.labelLarge,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                singleArticleController
                                    .articleSingleModel.value.createdAt!,
                                style: textTheme.labelLarge,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: HtmlWidget(
                            '''
                            <p style="text-align: justify; line-height: 1.9">    
    
                           ${singleArticleController.articleSingleModel.value.content!}
                        </p>
                                ''',
                            textStyle: textTheme.titleSmall,
                            enableCaching: true,
                            onLoadingBuilder:
                                (context, element, loadingProgress) =>
                                    const CircularProgressIndicator(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // category list -------------------------------
                        SizedBox(
                          height: 60,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount:
                                  singleArticleController.categoryList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    var catId = singleArticleController
                                        .categoryList[index].id!;
                                    await Get.find<ArticleController>()
                                        .getArticleLisByCatId(catId);
                                    Get.to(ArticleListScreen(
                                      title: singleArticleController
                                          .categoryList[index].title!,
                                    ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: ColorsBlog.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            singleArticleController
                                                .categoryList[index].title!,
                                            style: textTheme.labelMedium,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Divider(
                          indent: 7,
                          endIndent: 7,
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        // related articles-----------------------------------------------------------
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'مقالات مرتبط',
                              style: textTheme.titleMedium,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenSize.width < 420
                              ? screenSize.height / 3.4
                              : screenSize.height / 1.9,
                          width: double.infinity,
                          child: ListView.builder(
                              itemCount: singleArticleController
                                  .relatedArticleList.length,
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    singleArticleController.getArticleInfo(
                                        singleArticleController
                                            .relatedArticleList[index].id);
                                            Get.to(ArticleSingleScreen());
                                  },
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
                                              imageUrl: singleArticleController
                                                  .relatedArticleList[index]
                                                  .image!,
                                              imageBuilder:
                                                  (context, imageProvider) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  20)),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          blurRadius: 2,
                                                          offset: Offset(1, 2),
                                                          color: Colors.grey,
                                                        )
                                                      ],
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.fill),
                                                    ),
                                                    foregroundDecoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        gradient: const LinearGradient(
                                                            colors: ColorsBlog
                                                                .relatedArticleGradientColor,
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            singleArticleController
                                                                .relatedArticleList[
                                                                    index]
                                                                .author!,
                                                            style: textTheme
                                                                .labelSmall,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                singleArticleController
                                                                    .relatedArticleList[
                                                                        index]
                                                                    .view!,
                                                                style: textTheme
                                                                    .labelSmall,
                                                              ),
                                                              const SizedBox(
                                                                width: 3,
                                                              ),
                                                              const Icon(
                                                                Icons
                                                                    .remove_red_eye,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              placeholder: (context, url) =>
                                                  const SizedBox(
                                                      height: 60,
                                                      width: 60,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.grey,
                                                      )),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                Icons.image_not_supported,
                                                color: Colors.grey,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        width: screenSize.width < 480
                                            ? screenSize.height / 4
                                            : screenSize.height / 1.7,
                                        child: Text(
                                          singleArticleController
                                              .relatedArticleList[index].title!,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          style: textTheme.titleSmall,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
