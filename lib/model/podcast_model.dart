import 'package:haftsara_blog/components/url_api_constant.dart';

class PodcastModel {
  String? id;
  String? title;
  String? poster;
  String? publisher;
  String? view;
  String? careateAt;

  PodcastModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.publisher,
    required this.view,
    required this.careateAt,
  });

  PodcastModel.fromJson(Map<String, dynamic> podcastModelJson) {
    id = podcastModelJson['id'];
    title = podcastModelJson['title'];
    poster = UrlApiConstant.mainUrl + podcastModelJson['poster'];
    publisher = podcastModelJson['publisher'];
    view = podcastModelJson['view'];
    careateAt = podcastModelJson['careate_at'];
  }

}