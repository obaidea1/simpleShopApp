class HomeModel {
  bool? status;
  String? message;
  HomeDataModel? homeData;

  HomeModel({
    this.status,
    this.message,
    this.homeData,
  });

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    homeData = json["data"] != null ? HomeDataModel.fromJson(json["data"]) : null;
  }
}

class HomeDataModel {
  List<BannersModel> banners;
  List<ProductsModel> products;

  HomeDataModel({
    required this.banners,
    required this.products,
  });

  HomeDataModel.fromJson(Map<String, dynamic> json)
      : banners = (json["banners"] as List)
      .map((e) => BannersModel.fromJson(e))
      .toList(),
        products = (json["products"] as List)
            .map((e) => ProductsModel.fromJson(e))
            .toList();
}

class BannersModel {
  int? id;
  String? image;

  BannersModel({
    this.id,
    this.image,
  });

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  List<String> images;
  bool? inFavorites;
  bool? inCart;

  ProductsModel({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
    required this.images,
    this.inFavorites,
    this.inCart,
  });

  ProductsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        price = json['price'],
        oldPrice = json['old_price'],
        discount = json['discount'],
        image = json['image'],
        name = json['name'],
        description = json['description'],
        images = (json['images'] as List<dynamic>).cast<String>(),
        inFavorites = json['in_favorites'],
        inCart = json['in_cart'];
}
