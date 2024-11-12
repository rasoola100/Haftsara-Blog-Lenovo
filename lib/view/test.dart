// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:haftsara_blog/components/const_colors.dart';
// import 'package:haftsara_blog/controller/article_controller.dart';
// import 'package:haftsara_blog/gen/assets.gen.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:get/get.dart';
// import 'package:haftsara_blog/controller/single_article_controller.dart';
// import 'package:haftsara_blog/view/article_list_screen.dart';

// class SingleScreen extends StatelessWidget {
//   SingleScreen({super.key});

//   // SingleArticleController singleArticleController =
//   // Get.put(SingleArticleController());
//   var singleArticleController = Get.find<SingleArticleController>();

//   // ArticleController articleController = Get.put(ArticleController());

//   // @override
//   @override
//   Widget build(BuildContext context) {
//     // var id = Get.arguments[0];
//     var screenSize = MediaQuery.of(context).size;
//     var textTheme = Theme.of(context).textTheme;
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Obx(
//             () => singleArticleController.articleInfoModel.value.id == null
//                 ? SizedBox(
//                     height: Get.height,
//                     child: const Center(
//                       child: CircularProgressIndicator(
//                         color: ConstColors.secondaryColor,
//                       ),
//                     ),
//                   )
//                 : Column(
//                     children: [
//                       Stack(
//                         children: [
//                           CachedNetworkImage(
//                             imageUrl: singleArticleController
//                                 .articleInfoModel.value.image!,
//                             imageBuilder: (context, imageProvider) {
//                               return Image(
//                                 image: imageProvider,
//                                 fit: BoxFit.cover,
//                               );
//                             },
//                             placeholder: (context, url) {
//                               return const CircularProgressIndicator(
//                                 color: ConstColors.primaryColor,
//                               );
//                             },
//                             errorWidget: (context, url, error) {
//                               return SizedBox(
//                                 width: screenSize.width,
//                                 child: Image(
//                                   image: AssetImage(Assets.images.linux.path),
//                                   fit: BoxFit.cover,
//                                 ),
//                               );
//                             },
//                           ),
//                           Positioned(
//                             top: 0,
//                             left: 0,
//                             child: Container(
//                                 height: 60,
//                                 width: screenSize.width,
//                                 decoration: const BoxDecoration(
//                                     gradient: LinearGradient(
//                                         colors: ConstColors.appBarGradientColor,
//                                         begin: Alignment.topCenter,
//                                         end: Alignment.bottomCenter)),
//                                 child: Row(
//                                   children: [
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                     InkWell(
//                                       onTap: () => Get.back(),
//                                       child: const Icon(
//                                         Icons.arrow_back,
//                                         size: 30,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                     const Expanded(
//                                       child: SizedBox(),
//                                     ),
//                                     const Icon(
//                                       Icons.bookmark_border_outlined,
//                                       size: 30,
//                                       color: Colors.white,
//                                     ),
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                     const Icon(
//                                       Icons.share,
//                                       size: 30,
//                                       color: Colors.white,
//                                     ),
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                   ],
//                                 )),
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(14.0),
//                         child: Text(
//                           singleArticleController.articleInfoModel.value.title!,
//                           maxLines: 2,
//                           style: textTheme.headlineMedium,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           children: [
//                             ClipRRect(
//                                 borderRadius: BorderRadius.circular(50),
//                                 child: Image.asset(
//                                   Assets.images.avatar.path,
//                                   height: 50,
//                                 )),
//                             const SizedBox(
//                               width: 15,
//                             ),
//                             Text(
//                               singleArticleController
//                                   .articleInfoModel.value.author!,
//                               style: textTheme.headlineSmall,
//                             ),
//                             const SizedBox(
//                               width: 17,
//                             ),
//                             Text(
//                               singleArticleController
//                                   .articleInfoModel.value.createdAt!,
//                               style: textTheme.labelMedium,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
//                         child: HtmlWidget(
//                           '''
//                           <p style="text-align: justify">
//                             ${singleArticleController.articleInfoModel.value.content!},
//                           </p>
//                           ''',
//                           textStyle: textTheme.bodyMedium,
//                           enableCaching: true,
//                           onLoadingBuilder:
//                               (context, element, loadingProgress) {
//                             return const CircularProgressIndicator();
//                           },
//                         ),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.all(8),
//                         child: Divider(),
//                       ),
//                       // category list-----------------------------------------
//                       SizedBox(
//                         height: 50,
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 8.0),
//                           child: ListView.builder(
//                             itemCount:
//                                 singleArticleController.categoryList.length,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) {
//                               return InkWell(
//                                 onTap: () async {
//                                   var catId = singleArticleController
//                                       .categoryList[index].id!;
//                                   await Get.find<ArticleController>()
//                                       .getArticleListByCatId(catId);
//                                   // await articleController.getArticleListByCatId(catId);
//                                   Get.to(() => ArticleListScreen(
//                                       title: singleArticleController
//                                           .categoryList[index].title!));
//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 8.0),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(15),
//                                         color: const Color.fromARGB(
//                                             255, 104, 104, 104)),
//                                     child: Center(
//                                         child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(
//                                         singleArticleController
//                                             .categoryList[index].title!,
//                                         style: textTheme.titleSmall,
//                                       ),
//                                     )),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 22,
//                       ),
//                       Align(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.only(right: 8.0, bottom: 2),
//                             child: Text(
//                               'مقالات مرتبط',
//                               style: textTheme.headlineMedium,
//                             ),
//                           )),
//                       // related articles-----------------------------------------
//                       SizedBox(
//                         height: Get.width / 2,
//                         child: ListView.builder(
//                             itemCount: singleArticleController
//                                 .relatedArticleList.length,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) {
//                               return InkWell(
//                                 onTap: () {
//                                   singleArticleController.getArticleInfo(
//                                       singleArticleController
//                                           .relatedArticleList[index].id);
//                                 },
//                                 child: Column(
//                                   children: [
//                                     SizedBox(
//                                       height: Get.width / 3.5,
//                                       width: Get.width / 2.9,
//                                       child: CachedNetworkImage(
//                                         imageUrl: singleArticleController
//                                             .relatedArticleList[index].image!,
//                                         imageBuilder:
//                                             (contetxt, imageProvider) {
//                                           return Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Stack(children: [
//                                               Container(
//                                                 decoration: BoxDecoration(
//                                                   image: DecorationImage(
//                                                       image: imageProvider,
//                                                       fit: BoxFit.cover),
//                                                   borderRadius:
//                                                       BorderRadius.circular(15),
//                                                   boxShadow: const [
//                                                     BoxShadow(blurRadius: 2)
//                                                   ],
//                                                 ),
//                                                 foregroundDecoration:
//                                                     BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(15),
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: ConstColors
//                                                         .homePosterGradientColor,
//                                                     begin: Alignment.topCenter,
//                                                     end: Alignment.bottomCenter,
//                                                   ),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 left: 0,
//                                                 right: 0,
//                                                 bottom: 5,
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceAround,
//                                                   children: [
//                                                     Text(
//                                                       singleArticleController
//                                                           .relatedArticleList[
//                                                               index]
//                                                           .author!,
//                                                       style: textTheme
//                                                           .displaySmall,
//                                                     ),
//                                                     Row(
//                                                       children: [
//                                                         Text(
//                                                             singleArticleController
//                                                                 .relatedArticleList[
//                                                                     index]
//                                                                 .view!,
//                                                             style: textTheme
//                                                                 .displaySmall),
//                                                         const SizedBox(
//                                                           width: 3,
//                                                         ),
//                                                         const Icon(
//                                                           Icons.remove_red_eye,
//                                                           color: Colors.white,
//                                                           size: 15,
//                                                         )
//                                                       ],
//                                                     )
//                                                   ],
//                                                 ),
//                                               )
//                                             ]),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 6,
//                                     ),
//                                     SizedBox(
//                                       width: Get.width / 2.9,
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(right: 10.0),
//                                         child: Text(
//                                           singleArticleController
//                                               .relatedArticleList[index].title!,
//                                           style: textTheme.bodySmall,
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               );
//                             }),
//                       ),
//                     ],
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }
