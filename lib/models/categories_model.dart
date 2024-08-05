class CategoriesModel {
  bool? status;
  CategoriesDataModel? dataModel;

  CategoriesModel(){
    status;
    dataModel;
  }
  CategoriesModel.fromJson(Map<String,dynamic> json){
    status = json["status"];
    dataModel = CategoriesDataModel.fromJson(json['data']);
  }

}
class CategoriesDataModel {
  int? currentPage;
  List<CategoriesDetailDataModel> data = [];

  CategoriesDataModel.fromJson(Map<String,dynamic> json){
    currentPage = json["current_page"];
    data = (json["data"] as List).map((element) => CategoriesDetailDataModel.fromJson(element)).toList();
  }

}
class CategoriesDetailDataModel {
  int? id;
  String? name;
  String? image;
  CategoriesDetailDataModel.fromJson(Map<String,dynamic> json){
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }
}