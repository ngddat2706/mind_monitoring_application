import 'dart:convert';

ModelValueRawLast5Min modelValueRawLast5MinFromJson(String str) => ModelValueRawLast5Min.fromJson(json.decode(str));

String modelValueRawLast5MinToJson(List<ModelValueRawLast5Min> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelValueRawLast5Min {
    List<int> values;
    List<DateTime> recivedTimes;

    ModelValueRawLast5Min({
      required  this.values,
      required  this.recivedTimes,
    });

    factory ModelValueRawLast5Min.fromJson(Map<String, dynamic> json) => ModelValueRawLast5Min(
        values: List<int>.from(json["values"].map((x) => x)),
        recivedTimes: List<DateTime>.from(json["recivedTimes"].map((x) => DateTime.parse(x))),
    );

    Map<String, dynamic> toJson() => {
        "values": List<dynamic>.from(values.map((x) => x)),
        "recivedTimes": List<dynamic>.from(recivedTimes.map((x) => x.toIso8601String())),
    };
}
