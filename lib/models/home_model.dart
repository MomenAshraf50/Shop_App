class HomeModel{
  late bool status;
  HomeData? data;

  HomeModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = HomeData.fromJson(json['data']);
  }
}

class HomeData{
  List<HomeBanner> banners = [];
  List<HomeProducts> products = [];

  HomeData.fromJson(Map<String,dynamic> json){
    json['banners'].forEach((element){
      banners.add(HomeBanner.fromJson(element));
    });
    json['products'].forEach((element){
      products.add(HomeProducts.fromJson(element));
    });

  }

}

class HomeBanner{
  int? id;
  String? image;
  HomeBanner.fromJson(Map<String,dynamic> json){
    id = json['id'];
    image = json['image'];
  }

}

class HomeProducts{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  HomeProducts.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];

  }

}