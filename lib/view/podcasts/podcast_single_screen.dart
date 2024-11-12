import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:haftsara_blog/components/colors_blog.dart';
import 'package:haftsara_blog/controllers/single_podcast_controller.dart';
import 'package:haftsara_blog/gen/assets.gen.dart';
import 'package:haftsara_blog/model/podcast_model.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PodcastSingleScreen extends StatelessWidget {
  // PodcastSingleScreen({super.key});

  late SinglePodcastController singlePodcastController;
  late PodcastModel podcastModel;
  PodcastSingleScreen({super.key}) {
    podcastModel = Get.arguments;
    singlePodcastController =
        Get.put(SinglePodcastController(id: podcastModel.id));
  }

  // @override
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(
            () => Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: screenSize.width < 420
                          ? screenSize.height / 3
                          : screenSize.height / 1.5,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: podcastModel.poster!,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
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
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      podcastModel.title!,
                      style: textTheme.titleSmall,
                    ),
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
                        // podcastModel.publisher!, خطای نال چک می‌دهد
                        'رسول امیری',
                        style: textTheme.labelLarge,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        // podcastModel.careateAt!,
                        'دو روز قبل',
                        style: textTheme.labelLarge,
                      )
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                // podcast list -------------------------------
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: singlePodcastController.podcastSingleList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          await singlePodcastController.player
                              .seek(Duration.zero, index: index);
                          singlePodcastController.currentPodcastIndex.value =
                              singlePodcastController.player.currentIndex!;
                          singlePodcastController.timerCheck();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              ImageIcon(
                                Assets.icons.podcast.provider(),
                                color: ColorsBlog.primaryColor,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                width: Get.width / 1.5,
                                child: Text(
                                  singlePodcastController
                                      .podcastSingleList[index].title!,
                                  style: singlePodcastController
                                              .currentPodcastIndex.value ==
                                          index
                                      ? textTheme.titleSmall
                                      : textTheme.titleMedium,
                                ),
                              ),
                              const Expanded(
                                child: SizedBox(),
                              ),
                              Text(
                                '${singlePodcastController.podcastSingleList[index].length!}:00',
                                style: textTheme.titleSmall,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: Get.width < 420 ? Get.height / 6.5 : Get.height / 3,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 34, 34, 34),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 16, 10, 6),
                        child: ProgressBar(
                          timeLabelLocation: TimeLabelLocation.below,
                          timeLabelTextStyle:
                              const TextStyle(color: Colors.yellow),
                          baseBarColor: Colors.white,
                          thumbColor: Colors.green,
                          progressBarColor: Colors.orange,
                          progress:
                              singlePodcastController.progressDuration.value,
                          total: singlePodcastController.player.duration ??
                              const Duration(seconds: 0),
                          buffered:
                              singlePodcastController.bufferDuration.value,
                          onSeek: (position) async {
                            singlePodcastController.player.seek(position);
                            // singlePodcastController.player.playing
                            //     ? singlePodcastController.setPorgress()
                            //     : singlePodcastController.timer!.cancel();

                            if (singlePodcastController.player.playing) {
                              singlePodcastController.timerCheck();
                            } else if (position <= const Duration(seconds: 0)) {
                              await singlePodcastController.player.seekToNext();
                              singlePodcastController
                                      .currentPodcastIndex.value =
                                  singlePodcastController.player.currentIndex!;
                              singlePodcastController.timerCheck();
                            }
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () async {
                              await singlePodcastController.player.seekToNext();
                              singlePodcastController
                                      .currentPodcastIndex.value =
                                  singlePodcastController.player.currentIndex!;
                              singlePodcastController.timerCheck();
                            },
                            child: const Icon(
                              Icons.skip_next,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              // print(singlePodcastController.player.playing);

                              singlePodcastController.player.playing
                                  ? singlePodcastController.timer!.cancel()
                                  : singlePodcastController.setPorgress();

                              singlePodcastController.player.playing
                                  ? await singlePodcastController.player.pause()
                                  : await singlePodcastController.player.play();

                              singlePodcastController.playState.value =
                                  singlePodcastController.player.playing;

                              singlePodcastController
                                      .currentPodcastIndex.value =
                                  singlePodcastController.player.currentIndex!;
                            },
                            child: Icon(
                              singlePodcastController.playState.value
                                  ? Icons.play_circle_fill
                                  : Icons.pause_circle_filled,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              singlePodcastController.player.seekToPrevious();
                              singlePodcastController
                                      .currentPodcastIndex.value =
                                  singlePodcastController.player.currentIndex!;
                              singlePodcastController.timerCheck();
                            },
                            child: const Icon(
                              Icons.skip_previous,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.repeat,
                              color: singlePodcastController.isLoopAll.value
                                  ? Colors.red
                                  : Colors.white,
                              size: 35,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
