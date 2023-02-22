class FavoritesModel {
  bool? status;
  Null? message;
  Data? data;

  FavoritesModel.empty() {
    data = Data.empty();
  }

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<favoritesData>? data = [];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  Data.empty() {}

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    // if (json['data'] != null) {
    //   data = <favoritesData>[];
    //   json['data'].forEach((v) {
    //     data!.add(new favoritesData.fromJson(v));
    //   });
    // }
    if (json['data'] != null) {
      json['data'].forEach((element) {
        data!.add(favoritesData.fromJson(element));
      });
    }

    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class favoritesData {
  int? id;
  Product? product;

  favoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
