import 'BaseResponse.dart';

class LoginResponse extends BaseResponse {
  String first_name;
  String last_name;
  String profile_image;
  String token;
  String user_display_name;
  String user_email;
  int user_id;
  String user_nicename;

  LoginResponse({this.first_name, this.last_name, this.profile_image, this.token, this.user_display_name, this.user_email, this.user_id, this.user_nicename});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      first_name: json['first_name'],
      last_name: json['last_name'],
      profile_image: json['profile_image'],
      token: json['token'],
      user_display_name: json['user_display_name'],
      user_email: json['user_email'],
      user_id: json['user_id'],
      user_nicename: json['user_nicename'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.first_name;
    data['last_name'] = this.last_name;
    data['profile_image'] = this.profile_image;
    data['token'] = this.token;
    data['user_display_name'] = this.user_display_name;
    data['user_email'] = this.user_email;
    data['user_id'] = this.user_id;
    data['user_nicename'] = this.user_nicename;
    return data;
  }
}
