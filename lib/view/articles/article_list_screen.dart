import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haftsara_blog/components/helper.dart';
import 'package:haftsara_blog/components/route_name.dart';
import 'package:haftsara_blog/controllers/article_controller.dart';
import 'package:haftsara_blog/controllers/single_article_controller.dart';
import 'package:haftsara_blog/view/articles/article_single_screen.dart';

class ArticleListScreen extends StatelessWidget {
  late final String title;
  ArticleListScreen({super.key, required this.title});
  final ArticleController articleController = Get.put(ArticleController());
  // final SingleArticleController singleArticleController = Get.put(SingleArticleController());


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: appBar(title),
        body: Obx( 
          () => SizedBox(
            child: ListView.builder(
                itemCount: articleController.articleList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async{
                      // singleArticleController.id.value = articleController.articleList[index].id!;
                      // await singleArticleController.getArticleInfo(articleController.articleList[index].id);
                     await Get.find<SingleArticleController>().getArticleInfo(articleController.articleList[index].id);
                      // Get.to(() => ArticleSingleScreen());
                      Get.toNamed(RouteName.routeSingleArticleScreen);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: screenSize.width < 420
                                ? screenSize.height / 6.5
                                : screenSize.height / 3,
                            width: screenSize.width < 420
                                ? screenSize.height / 5.5
                                : screenSize.height / 2.5,
                            child: CachedNetworkImage(
                              imageUrl:
                                  articleController.articleList[index].image!,
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 3,
                                            offset: Offset(1, 2),
                                            color:
                                                Color.fromARGB(255, 51, 51, 51))
                                      ],
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill)),
                                );
                              },
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                color: Colors.grey,
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.image_not_supported,
                                size: 35,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 3, 10, 4),
                              child: Column(
                                children: [
                                  Text(
                                    articleController.articleList[index].title!,
                                    style: textTheme.titleSmall,
                                    overflow: TextOverflow.ellipsis, maxLines: 2,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                    Text(articleController.articleList[index].author!),
                                    Text('بازدید ${articleController.articleList[index].view!}'),
                                  ],)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
