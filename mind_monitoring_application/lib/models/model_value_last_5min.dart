import 'dart:convert';

ModelValueLast5Min modelValueLast5MinFromJson(String str) => ModelValueLast5Min.fromJson(json.decode(str));

// String modelValueLast5MinToJson(ModelValueLast5Min data) => json.encode(data.toJson());

class ModelValueLast5Min {
    List<General> generals;
    List<Data8Band> data8Bands;

    ModelValueLast5Min({
        required this.generals,
        required this.data8Bands,
    });

    factory ModelValueLast5Min.fromJson(Map<String, dynamic> json) => ModelValueLast5Min(
        generals: List<General>.from(json["generals"].map((x) => General.fromJson(x))),
        data8Bands: List<Data8Band>.from(json["data8Bands"].map((x) => Data8Band.fromJson(x))),
    );

    // Map<String, dynamic> toJson() => {
    //     "generals": List<dynamic>.from(generals.map((x) => x.toJson())),
    //     "data8Bands": List<dynamic>.from(data8Bands.map((x) => x.toJson())),
    // };
}

class Data8Band {
    String id;
    int delta;
    int theta;
    int alpha;
    int lowBeta;
    int midBeta;
    int highBeta;
    int gamma;
    int uhfGamma;
    String deviceDataId;
    bool isDeleted;
    DateTime createdTime;
    String createdBy;
    DateTime lastModifiedTime;
    String lastModifiedBy;

    Data8Band({
        required this.id,
        required this.delta,
        required this.theta,
        required this.alpha,
        required this.lowBeta,
        required this.midBeta,
        required this.highBeta,
        required this.gamma,
        required this.uhfGamma,
        required this.deviceDataId,
        required this.isDeleted,
        required this.createdTime,
        required this.createdBy,
        required this.lastModifiedTime,
        required this.lastModifiedBy,
    });

    factory Data8Band.fromJson(Map<String, dynamic> json) => Data8Band(
        id: json["id"],
        delta: json["delta"]??0,
        theta: json["theta"]??0,
        alpha: json["alpha"]??0,
        lowBeta: json["lowBeta"]??0,
        midBeta: json["midBeta"]??0,
        highBeta: json["highBeta"]??0,
        gamma: json["gamma"]??0,
        uhfGamma: json["uhfGamma"]??0,
        deviceDataId: json["deviceDataId"],
        isDeleted: json["isDeleted"],
        createdTime: DateTime.parse(json["createdTime"]),
        createdBy: json["createdBy"],
        lastModifiedTime: DateTime.parse(json["lastModifiedTime"]),
        lastModifiedBy: json["lastModifiedBy"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "delta": delta,
        "theta": theta,
        "alpha": alpha,
        "lowBeta": lowBeta,
        "midBeta": midBeta,
        "highBeta": highBeta,
        "gamma": gamma,
        "uhfGamma": uhfGamma,
        "deviceDataId": deviceDataId,
        "isDeleted": isDeleted,
        "createdTime": createdTime.toIso8601String(),
        "createdBy": createdBy,
        "lastModifiedTime": lastModifiedTime.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
    };
}


class General {
    String id;
    int poorQuality;
    int attention;
    int meditation;
    String deviceId;
    bool isDeleted;
    DateTime createdTime;
    String createdBy;
    DateTime lastModifiedTime;
    String lastModifiedBy;

    General({
        required this.id,
        required this.poorQuality,
        required this.attention,
        required this.meditation,
        required this.deviceId,
        required this.isDeleted,
        required this.createdTime,
        required this.createdBy,
        required this.lastModifiedTime,
        required this.lastModifiedBy,
    });

    factory General.fromJson(Map<String, dynamic> json) => General(
        id: json["id"],
        poorQuality: json["poorQuality"]??0,
        attention: json["attention"]??0,
        meditation: json["meditation"],
        deviceId: json["deviceId"],
        isDeleted: json["isDeleted"],
        createdTime: (json["createdTime"]!=null)?DateTime.parse(json["createdTime"]):DateTime.now(),
        createdBy: json["createdBy"],
        lastModifiedTime: DateTime.parse(json["lastModifiedTime"]),
        lastModifiedBy: json["lastModifiedBy"],
    );

    // Map<String, dynamic> toJson() => {
    //     "id": id,
    //     "poorQuality": poorQuality,
    //     "attention": attention,
    //     "meditation": meditation,
    //     "deviceId": deviceId,
    //     "isDeleted": isDeleted,
    //     "createdTime": createdTime.toIso8601String(),
    //     "createdBy": createdBy,
    //     "lastModifiedTime": lastModifiedTime.toIso8601String(),
    //     "lastModifiedBy": lastModifiedBy,
    // };
}
