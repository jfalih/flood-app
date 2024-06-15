class SearchModel {
  bool? status;
  List<SearchData>? data;

  SearchModel({this.status, this.data});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      status: json['status'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => SearchData.fromJson(i)).toList()
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

class SearchData {
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
  Category? category;

  SearchData({
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
    this.category,
  });

  factory SearchData.fromJson(Map<String, dynamic> json) {
    return SearchData(
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
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
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
      'category': category?.toJson(),
    };
  }
}

class Category {
  int? id;
  String? name;
  String? icon;
  String? image;
  String? createdAt;
  String? updatedAt;

  Category({
    this.id,
    this.name,
    this.icon,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
