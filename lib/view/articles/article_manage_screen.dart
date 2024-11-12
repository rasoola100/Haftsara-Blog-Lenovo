import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:haftsara_blog/components/helper.dart';
import 'package:haftsara_blog/route_manager/route_name.dart';
import 'package:haftsara_blog/controllers/manage_article_controller.dart';
import 'package:haftsara_blog/gen/assets.gen.dart';

class ArticleManageScreen extends StatelessWidget {
  ArticleManageScreen({super.key});

  // var manageArticleController = Get.find<ManageArticleController>();
  final ManageArticleController manageArticleController =
      Get.put(ManageArticleController());
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: appBar('مدیریت مقاله‌ها'),
      body: SafeArea(
        child: Obx(
          () => manageArticleController.loading.value == true
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.grey,
                ))
              : manageArticleController.articleList.isNotEmpty ?
              SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: ListView.builder(
                        itemCount: manageArticleController.articleList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                             var id = manageArticleController.articleList[index].id;
                             print(id);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: Get.width < 420
                                        ? Get.height / 8
                                        : Get.height / 3,
                                    width: Get.width < 420
                                        ? Get.height / 7
                                        : Get.height / 2.5,
                                    child: CachedNetworkImage(
                                        imageUrl: manageArticleController
                                            .articleList[index].image!,
                                        imageBuilder: (context, imageProvider) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: const [
                                                BoxShadow(
                                                    blurRadius: 2,
                                                    offset: Offset(1, 2),
                                                    color: Color.fromARGB(
                                                        255, 77, 76, 76))
                                              ],
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill),
                                            ),
                                          );
                                        },
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(
                                                color: Colors.grey),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                              Icons.image_not_supported,
                                              size: 30,
                                              color: Colors.grey,
                                            )),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 3, 10, 4),
                                    child: Column(
                                      children: [
                                        Text(
                                          manageArticleController
                                              .articleList[index].title!,
                                          style: textTheme.titleSmall,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                            'بازدید ${manageArticleController.articleList[index].view!}'),
                                      ],
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                      
                ) : articleEmptyState(textTheme),
              
        ),
        
      ),
      bottomNavigationBar: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if(states.contains(WidgetState.pressed)) {
                  return Colors.grey;
                }
                return Colors.green;
              }),
            ),
            onPressed: () {
              Get.toNamed(RouteName.routeSingleManageArticleScreen);
            },
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text('ایجاد مقاله جدید', style: TextStyle(color: Colors.white),),
            ),
            ),
    );
  }

  Widget articleEmptyState(TextTheme textTheme) {
    return Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          SvgPicture.asset(
            Assets.images.robotIcon,
            height: 100,
            colorFilter:
                const ColorFilter.mode(Colors.orange, BlendMode.srcATop),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('''شما تاکنون مقاله‌ای منتشر نکرده‌اید
    برای ایجاد مقاله جدید می توانید از دکمه زیر استفاده کنید
        ''', style: textTheme.titleSmall, textAlign: TextAlign.center,),
          ),
      const SizedBox(
            height: 40,
          ),
          
        ],
      );
  }
}
