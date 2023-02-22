class ChangeFavoritesModel {
  bool? status;
  String? message;

  ChangeFavoritesModel.empty() {}

  ChangeFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
