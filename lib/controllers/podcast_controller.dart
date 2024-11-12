import 'package:get/get.dart';
import 'package:haftsara_blog/model/podcast_model.dart';
import 'package:haftsara_blog/services/dio_service.dart';

class PodcastController extends GetxController{
  RxList<PodcastModel> podcastList = RxList.empty();
  RxBool loading = false.obs;

  @override  
  void onInit() {
    super.onInit();
    getPodcast();
  }

  getPodcast() async{
    loading.value = true; 
    var url = 'https://techblog.sasansafari.com/Techblog/api/podcast/get.php?command=new&user_id=';
    var response = await DioService().getMethod(url);
    if(response.statusCode == 200) {
      response.data.forEach((element) {
        podcastList.add(PodcastModel.fromJson(element));
      });
      loading.value = false;
    }
  }

}