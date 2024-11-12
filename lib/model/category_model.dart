class CategoryModel {
  String? id;
  String? title;

  CategoryModel({required this.id, required this.title});

  CategoryModel.fromJson(Map<String, dynamic> categoryModelJson) {
    id = categoryModelJson['id'];
    title = categoryModelJson['title'];
  }
}
