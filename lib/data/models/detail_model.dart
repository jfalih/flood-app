class DetailModel {
  bool? status;
  List<DetailData>? data;

  DetailModel({this.status, this.data});

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      status: json['status'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => DetailData.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((i) => i.toJson()).toList(),
    };
  }
}

class DetailData {
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

  DetailData({
    this.id,
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
    this.updatedAt,
  });

  factory DetailData.fromJson(Map<String, dynamic> json) {
    return DetailData(
      id: json['id'],
      name: json['name'],
      categoryId: json['category_id'],
      address: json['address'],
      email: json['email'],
      phone: json['phone'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      image1: json['image1'],
      image2: json['image2'],
      image3: json['image3'],
      image4: json['image4'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category_id': categoryId,
      'address': address,
      'email': email,
      'phone': phone,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'image1': image1,
      'image2': image2,
      'image3': image3,
      'image4': image4,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
