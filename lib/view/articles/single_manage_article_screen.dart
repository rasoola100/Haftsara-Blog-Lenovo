import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:haftsara_blog/components/colors_blog.dart';
import 'package:haftsara_blog/controllers/file_controller.dart';
import 'package:haftsara_blog/controllers/home_controller.dart';
import 'package:haftsara_blog/controllers/manage_article_controller.dart';
import 'package:haftsara_blog/services/pick_file.dart';
import 'package:haftsara_blog/view/articles/article_content_editor.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class SingleManageArticleScreen extends StatelessWidget {
  SingleManageArticleScreen({super.key});
  final manageSingleArtcileController = Get.find<ManageArticleController>();
  final FileController fileController = Get.put(FileController());
  final HtmlEditorController htmlEditorController = HtmlEditorController();
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          htmlEditorController.clearFocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: Get.width < 420 ? Get.height / 3 : Get.height / 2,
                      child: fileController.file.value.size == 0
                          ? CachedNetworkImage(
                              imageUrl: manageSingleArtcileController
                                      .articleSingleModel.value.image ??
                                  '',
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 2,
                                          offset: Offset(1, 2),
                                          color: Colors.black38)
                                    ],
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                );
                              },
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                color: Colors.grey,
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.image_not_supported,
                                size: 30,
                                color: Colors.grey,
                              ),
                            )
                          : Image.file(File(fileController.file.value.path!)),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      child: Container(
                        height: 60,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors:
                                    ColorsBlog.articleSingleAppBarGradientColor,
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
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll<Color?>(
                                  Colors.blue[400]),
                              shape: const WidgetStatePropertyAll<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                              ),
                            ),
                            onPressed: () {
                              pickFile();
                            },
                            child: Text(
                              'انتخاب تصویر',
                              style: textTheme.labelMedium,
                            )))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        getTitle();
                      },
                      child: Text(
                        manageSingleArtcileController
                                .articleSingleModel.value.title ??
                            'برای نوشتن عنوان کلیک کنید',
                        style: textTheme.titleSmall,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                InkWell(
                  onTap: () => Get.to(() => ArticleContentEditor()),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HtmlWidget(
                      """
                       <p style="text-align: justify; line-height: 1.9">   
                       ${manageSingleArtcileController.articleSingleModel.value.content ?? 'برای نوشتن محتوا اینجا را کلیک کنید'},
                        </p> 
                      """,
                      textStyle: textTheme.titleSmall,
                      enableCaching: true,
                      onLoadingBuilder: (context, element, loadingProgress) =>
                          const CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => chooseCatsBottomSheet(textTheme),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'انتخاب دسته‌بندی',
                          style: textTheme.titleMedium,
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      manageSingleArtcileController
                              .articleSingleModel.value.catName ??
                          'دسته‌ای انتخاب نشده است',
                      style: textTheme.titleSmall,
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () async{
               await manageSingleArtcileController.storeArticle();
                },
                child: Text(
                  manageSingleArtcileController.loading.value ? 'در حال ارسال...' : 'ثبت',
                  style: const TextStyle(color: Colors.white),
                )),
          ),
        ),
      ),
    );
  }

  void getTitle() {
    Get.defaultDialog(
      title: 'عنوان',
      titleStyle: const TextStyle(color: Colors.black87),
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      radius: 10,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: manageSingleArtcileController.titleTextEditingController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
              hintText: 'اینجا بنویسید',
              hintStyle: TextStyle(
                  color: Color.fromARGB(255, 150, 149, 149),
                  fontSize: 18,
                  fontWeight: FontWeight.w400)),
        ),
      ),
      confirm: ElevatedButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          onPressed: () {
            manageSingleArtcileController.updateTitle();
            Get.back();
          },
          child: const Text(
            'ثبت',
            style: TextStyle(color: Colors.white),
          )),
      cancel: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.red)),
          onPressed: () => Get.back(),
          child: const Text(
            'انصراف',
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  chooseCatsBottomSheet(TextTheme textTheme) {
    Get.bottomSheet(
      isScrollControlled: true,
      persistent: true,
      backgroundColor: Colors.white,
      Container(
        height: Get.width < 420 ? Get.height / 3 : Get.height / 2,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'دسته‌بندی‌ها',
                style: textTheme.titleSmall,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 125,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      childAspectRatio: .4),
                  itemCount: homeController.categoryList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // manageSingleArtcileController.articleSingleModel.value.catId =
                        // homeController.categoryList[index].id;
                        // manageSingleArtcileController.articleSingleModel.value.catName =
                        // homeController.categoryList[index].title;
                        manageSingleArtcileController.articleSingleModel.update((fn) {
                          fn?.catId = homeController.categoryList[index].id;
                          fn?.catName = homeController.categoryList[index].title;
                        });
                        Get.back();

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 58, 58, 58),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 7, 15, 7),
                            child: Center(
                              child: Text(
                                homeController.categoryList[index].title!,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 243, 243, 243),
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
