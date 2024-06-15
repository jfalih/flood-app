class ScheduleResponse {
  bool? status;
  ScheduleData? data;
  String? message;

  ScheduleResponse({this.status, this.data, this.message});

  ScheduleResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? ScheduleData.fromJson(json['data']) : null;
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

class ScheduleData {
  String? placeId;
  String? donorDate;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  ScheduleData(
      {this.placeId,
      this.donorDate,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});

  ScheduleData.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    donorDate = json['donor_date'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['place_id'] = placeId;
    data['donor_date'] = donorDate;
    data['user_id'] = userId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
