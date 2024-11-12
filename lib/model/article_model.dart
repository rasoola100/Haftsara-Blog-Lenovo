import 'package:haftsara_blog/components/url_api_constant.dart';

class ArticleModel {
  String? id;
  String? title;
  String? image;
  String? catId;
  String? catName;
  String? author;
  String? status;
  String? careateAt;
  String? view;
  String? isFavorite;
  

  ArticleModel({
    required this.id,
    required this.title,
    required this.image,
    required this.catId,
    required this.catName,
    required this.author,
    required this.status,
    required this.careateAt,
    required this.view,
    this.isFavorite,
  });

  ArticleModel.fromJson(Map<String, dynamic> articleModelJson) {
    id = articleModelJson['id'];
    title = articleModelJson['title'];
    image = UrlApiConstant.mainUrl + articleModelJson['image'];
    catId = articleModelJson['cat_id'];
    catName = articleModelJson['cat_name'];
    author = articleModelJson['author'];
    status = articleModelJson['status'];
    careateAt = articleModelJson['careate_at'];
    view = articleModelJson['view'];
  }

}
