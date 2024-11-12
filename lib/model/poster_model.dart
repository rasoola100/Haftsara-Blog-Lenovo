import 'package:haftsara_blog/components/url_api_constant.dart';

class PosterModel {
  String? id;
  String? title;
  String? image;

  PosterModel({
     this.id,
     this.title,
     this.image
  });

  PosterModel.fromJson(Map<String, dynamic> posterModelJson) {
    id = posterModelJson['id'];
    title = posterModelJson['title'];
    image = UrlApiConstant.mainUrl + posterModelJson['image'];
  }

}