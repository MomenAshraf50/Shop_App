class FavoritesModel{
  late bool status;
  List<FavoritesData> data =[];
  FavoritesModel.fromJson(Map<String,dynamic>? json){
    status = json?['status'];
    json?['data']['data'].forEach((element){
      data.add(FavoritesData.fromJson(element));
    });
  }
}

class FavoritesData{
  int? id;
  Product? favoriteProduct;

  FavoritesData.fromJson(Map<String,dynamic>? json){
    id = json?['id'];
    favoriteProduct = Product.fromJson(json?['product']);
  }

}


class Product{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;

  Product.fromJson(Map<String,dynamic>? json){
    id = json?['id'];
    price = json?['price'];
    oldPrice = json?['old_price'];
    discount = json?['discount'];
    image = json?['image'];
    name = json?['name'];
  }
}