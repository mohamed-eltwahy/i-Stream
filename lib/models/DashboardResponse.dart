import 'package:streamit_flutter/models/MovieData.dart';

class DashboardResponse {
  List<MovieData> banner;
  List<Slider> sliders;

  DashboardResponse({this.banner, this.sliders});

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      banner: json['banner'] != null ? (json['banner'] as List).map((i) => MovieData.fromJson(i)).toList() : null,
      sliders: json['sliders'] != null ? (json['sliders'] as List).map((i) => Slider.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banner != null) {
      data['banner'] = this.banner.map((v) => v.toJson()).toList();
    }
    if (this.sliders != null) {
      data['sliders'] = this.sliders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slider {
  List<MovieData> data;
  String title;
  bool viewAll;

  Slider({this.data, this.title,this.viewAll});

  factory Slider.fromJson(Map<String, dynamic> json) {
    return Slider(
      data: json['data'] != null ? (json['data'] as List).map((i) => MovieData.fromJson(i)).toList() : null,
      title: json['title'],
      viewAll: json['view_all'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['view_all'] = this.viewAll;
    return data;
  }
}