// To parse this JSON data, do
//
//     final modelDevice = modelDeviceFromJson(jsonString);

import 'dart:convert';

List<ModelDevice> modelDeviceFromJson(String str) => List<ModelDevice>.from(json.decode(str).map((x) => ModelDevice.fromJson(x)));

String modelDeviceToJson(List<ModelDevice> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelDevice {
    bool? isDeleted;
    DateTime? createdTime;
    String? createdBy;
    DateTime? lastModifiedTime;
    String? lastModifiedBy;
    String? id;
    String? name;
    String? description;
    String? userId;
    bool? isActive;
    DateTime? activeTime;

    ModelDevice({
        this.isDeleted,
        this.createdTime,
        this.createdBy,
        this.lastModifiedTime,
        this.lastModifiedBy,
        this.id,
        this.name,
        this.description,
        this.userId,
        this.isActive,
        this.activeTime,
    });

    factory ModelDevice.fromJson(Map<String, dynamic> json) => ModelDevice(
        isDeleted: json["isDeleted"],
        createdTime: DateTime.parse(json["createdTime"]),
        createdBy: json["createdBy"],
        lastModifiedTime: DateTime.parse(json["lastModifiedTime"]),
        lastModifiedBy: json["lastModifiedBy"],
        id: json["id"],
        name: json["name"],
        description: json["description"],
        userId: json["userId"],
        isActive: json["isActive"],
        activeTime: DateTime.parse(json["activeTime"]),
    );

    Map<String, dynamic> toJson() => {
        "isDeleted": isDeleted,
        "createdTime": (createdTime??DateTime.now()).toIso8601String(),
        "createdBy": createdBy,
        "lastModifiedTime": (lastModifiedTime??DateTime.now()).toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "id": id,
        "name": name,
        "description": description,
        "userId": userId,
        "isActive": isActive,
        "activeTime": (activeTime??DateTime.now()).toIso8601String(),
    };
}
