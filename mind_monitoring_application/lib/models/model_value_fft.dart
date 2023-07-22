import 'dart:convert';

import 'package:mind_monitoring_application/models/model_value_raw_last_5min.dart';

ModelValueFft modelValueFftFromJson(String str) => ModelValueFft.fromJson(json.decode(str));

String modelValueFftToJson(ModelValueFft data) => json.encode(data.toJson());

class ModelValueFft {
    List<ModelValueRawLast5Min> frequencyAxis;
    List<ModelValueRawLast5Min> amplitudeSpectrum;

    ModelValueFft({
        required this.frequencyAxis,
        required this.amplitudeSpectrum,
    });

    factory ModelValueFft.fromJson(Map<String, dynamic> json) => ModelValueFft(
        frequencyAxis: List<ModelValueRawLast5Min>.from(json["frequencyAxis"].map((x) => ModelValueRawLast5Min.fromJson(x))),
        amplitudeSpectrum: List<ModelValueRawLast5Min>.from(json["amplitudeSpectrum"].map((x) => ModelValueRawLast5Min.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "frequencyAxis": List<dynamic>.from(frequencyAxis.map((x) => x.toJson())),
        "amplitudeSpectrum": List<dynamic>.from(amplitudeSpectrum.map((x) => x.toJson())),
    };
}
