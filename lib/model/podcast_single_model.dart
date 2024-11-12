class PodcastSingleModel {
  String? id;
  String? podcastId;
  String? file;
  String? title;
  String? length;
  
  PodcastSingleModel();

  PodcastSingleModel.fromJson(Map<String, dynamic> element) {
    var url = 'https://techblog.sasansafari.com/Techblog/api/podcast/get.php?command=get_files&podcasts_id=';
    id = element['id'];
    podcastId = element['podcast_id'];
    file = url + element['file'];
    title = element['title'];
    length = element['length'];
  }
}