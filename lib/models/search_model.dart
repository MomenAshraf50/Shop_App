class SearchModel{
  late bool status;
  List<Product> data =[];
  SearchModel.fromJson(Map<String,dynamic>? json){
    status = json?['status'];
    json?['data']['data'].forEach((element){
      data.add(Product.fromJson(element));
    });
  }
}



class Product{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;

  Product.fromJson(Map<String,dynamic>? json){
    id = json?['id'];
    price = json?['price'];
    oldPrice = json?['old_price'];
    discount = json?['discount'];
    image = json?['image'];
    name = json?['name'];
    inFavorites = json?['in_favorites'];
  }
}