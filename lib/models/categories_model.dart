class CategoriesModel{
  late bool status;
  List<CategoriesData> data = [];

  CategoriesModel.fromJson(Map<String,dynamic> json){
    status = json['status'];

    json['data']['data'].forEach((element){
      data.add(CategoriesData.fromJson(element));
    });
  }
}

class CategoriesData{
  int? id;
  String? name;
  String? image;

  CategoriesData.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}