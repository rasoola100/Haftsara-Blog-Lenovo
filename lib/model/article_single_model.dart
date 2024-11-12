import 'package:haftsara_blog/components/url_api_constant.dart';

class ArticleSingleModel {
  String? id;
  String? title;
  String? content;
  String? image;
  String? catId;
  String? catName;
  String? author;
  String? view;
  String? status;
  String? createdAt;
  String? isFavorite;

  // ArticleSingleModel({
  //   required this.id,
  //   required this.title,
  //   required this.content,
  //   required this.image,
  //   required this.catId,
  //   required this.catName,
  //   required this.author,
  //   required this.view,
  //   required this.status,
  //   required this.createdAt,
  //   this.isFavorite,
  // });

  ArticleSingleModel();

  ArticleSingleModel.fromJson(Map<String, dynamic> element) {
    var info = element['info'];
    id = info['id'] ?? '';
    title = info['title'] ?? '';
    content = info['content'] ?? '';
    image = UrlApiConstant.mainUrl + info['image'];
    catId = info['cat_id'] ?? '';
    catName = info['cat_name'] ?? '';
    author = info['author'] ?? '';
    view = info['view'] ?? '';
    status = info['status'] ?? '';
    createdAt = info['created_at'] ?? '';
    isFavorite = info['isFavorite'] ?? '';

  }


}