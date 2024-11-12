import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:haftsara_blog/model/podcast_single_model.dart';
import 'package:haftsara_blog/services/dio_service.dart';
import 'package:just_audio/just_audio.dart';

class SinglePodcastController extends GetxController {
  dynamic id;
  SinglePodcastController({this.id});
  RxBool loading = false.obs;
  RxList<PodcastSingleModel> podcastSingleList = RxList();
  final player = AudioPlayer();
  late dynamic playList;
  RxBool playState = false.obs;
  RxInt currentPodcastIndex = 0.obs;
  Timer? timer;
  Rx<Duration> progressDuration = const Duration(seconds: 0).obs;
  Rx<Duration> bufferDuration = const Duration(seconds: 0).obs;
  RxBool isLoopAll = false.obs;

  @override
  onInit() async {
    super.onInit();
    playList = ConcatenatingAudioSource(useLazyPreparation: true, children: []);

    await getPodcastById();
    await player.setAudioSource(playList,
        initialIndex: 0, initialPosition: Duration.zero);
  }

  getPodcastById() async {
    loading.value = true;
    var url =
        'https://techblog.sasansafari.com/Techblog/api/podcast/get.php?command=get_files&podcats_id=$id';
    var response = await DioService().getMethod(url);
    if (response.statusCode == 200) {
      for (var element in response.data['files']) {
        podcastSingleList.add(PodcastSingleModel.fromJson(element));
        playList.add(AudioSource.uri(
            Uri.parse(PodcastSingleModel.fromJson(element).file!)));
      }
      loading.value = false;
      log(playList.toString());
    }
  }

  setPorgress() {
    const tick = Duration(seconds: 1);
    int duration = player.duration!.inSeconds - player.position.inSeconds;
    if (timer != null) {
      if (timer!.isActive) {
        timer!.cancel();
        timer = null;
      }
      timer = Timer.periodic(tick, (timer) {
        duration--;
        progressDuration.value = player.position;
        bufferDuration.value = player.bufferedPosition;
        if (duration <= 0) {
          timer.cancel();
          progressDuration.value = const Duration(seconds: 0);
          bufferDuration.value = const Duration(seconds: 0);
        }
      });
    }
  }

  setLoopModeMusicPlayer() {
    if(isLoopAll.value) {
      isLoopAll.value == false;
      player.setLoopMode(LoopMode.off);
    } else {
      isLoopAll.value = true;
      player.setLoopMode(LoopMode.all);
    }
  }

  timerCheck() {
    if(player.playing) {
      setPorgress();
    } else {
      timer!.cancel();
      progressDuration.value = const Duration(seconds: 0);
      bufferDuration.value = const Duration(seconds: 0);
    }
  }

}
