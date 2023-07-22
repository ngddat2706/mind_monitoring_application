import 'dart:convert';

List<ModelValueRawLast5Min> modelValueRawLast5MinFromJson(String str) => List<ModelValueRawLast5Min>.from(json.decode(str).map((x) => ModelValueRawLast5Min.fromJson(x)));

String modelValueRawLast5MinToJson(List<ModelValueRawLast5Min> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelValueRawLast5Min {
    int value;
    DateTime recivedTime;

    ModelValueRawLast5Min({
        required this.value,
        required this.recivedTime,
    });

    factory ModelValueRawLast5Min.fromJson(Map<String, dynamic> json) => ModelValueRawLast5Min(
        value: json["value"],
        recivedTime: DateTime.parse(json["recivedTime"]),
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "recivedTime": recivedTime.toIso8601String(),
    };
}
