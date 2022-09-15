class UpdateFavoritesModel{
  late bool status;
  late String message;
  FavoritesData? data;

  UpdateFavoritesModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = FavoritesData.formJson(json['data']);
  }


}

class FavoritesData{
  int? id;
  FavoritesProduct? product;

  FavoritesData.formJson(Map<String,dynamic>? json){
    id = json?['id'];
    product = FavoritesProduct.fromJson(json?['product']);
  }
}

class FavoritesProduct{
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;

  FavoritesProduct.fromJson(Map<String,dynamic>? json){
    id = json?['id'];
    price = json?['price'];
    oldPrice= json?['old_price'];
    discount = json?['discount'];
    image = json?['image'];
  }
}