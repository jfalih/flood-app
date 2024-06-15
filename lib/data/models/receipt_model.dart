class ReceiptModel {
  bool? status;
  PlaceData? data;
  String? message;

  ReceiptModel({this.status, this.data, this.message});

  ReceiptModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? PlaceData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class PlaceData {
  int? id;
  int? placeId;
  int? userId;
  String? donorDate;
  String? status;
  String? createdAt;
  String? updatedAt;
  Place? place;

  PlaceData(
      {this.id,
      this.placeId,
      this.userId,
      this.donorDate,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.place});

  PlaceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    placeId = json['place_id'];
    userId = json['user_id'];
    donorDate = json['donor_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    place = json['place'] != null ? Place.fromJson(json['place']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['place_id'] = placeId;
    data['user_id'] = userId;
    data['donor_date'] = donorDate;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (place != null) {
      data['place'] = place!.toJson();
    }
    return data;
  }
}

class Place {
  int? id;
  String? name;
  int? categoryId;
  String? address;
  String? email;
  String? phone;
  String? description;
  String? latitude;
  String? longitude;
  String? image1;
  String? image2;
  String? image3;
  String? image4;
  String? createdAt;
  String? updatedAt;

  Place(
      {this.id,
      this.name,
      this.categoryId,
      this.address,
      this.email,
      this.phone,
      this.description,
      this.latitude,
      this.longitude,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.createdAt,
      this.updatedAt});

  Place.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    address = json['address'];
    email = json['email'];
    phone = json['phone'];
    description = json['description'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    image4 = json['image4'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category_id'] = categoryId;
    data['address'] = address;
    data['email'] = email;
    data['phone'] = phone;
    data['description'] = description;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['image1'] = image1;
    data['image2'] = image2;
    data['image3'] = image3;
    data['image4'] = image4;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
