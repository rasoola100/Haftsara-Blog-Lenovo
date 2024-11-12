import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:haftsara_blog/components/helper.dart';
import 'package:haftsara_blog/controllers/podcast_controller.dart';
import 'package:get/get.dart';

class PodcastListScreen extends StatelessWidget {
  PodcastListScreen({super.key});
  // final PodcastController podcastController = Get.find<PodcastController>();
  final PodcastController podcastController = Get.put(PodcastController());
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: appBar('فهرست پادکست‌ها'),
      body: SafeArea(
          child: Obx(
        () => SizedBox(
            child: ListView.builder(
          itemCount: podcastController.podcastList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    height: Get.width < 420 ? Get.height / 6.5 : Get.height / 3,
                    width: Get.width < 420 ? Get.height / 5.5 : Get.height / 2.5,
                    child: CachedNetworkImage(
                      imageUrl: podcastController.podcastList[index].poster!,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 2,
                                  offset: Offset(1, 2),
                                  color: Colors.black)
                            ],
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        );
                      },
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.image_not_supported,
                        size: 25,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          podcastController.podcastList[index].title!,
                          style: textTheme.titleSmall,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        )),
      )),
    );
  }
}
