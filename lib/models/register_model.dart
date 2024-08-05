class RegisterModel {
  bool? status;
  String? message;
  UserData? userData;


  RegisterModel({this.userData,this.message,this.status});

  RegisterModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    userData = json['data'] != null ? UserData.fromJson(json['data']): null;
  }
}
class UserData {
  String? name;
  String? phone;
  String? email;
  int? id;
  String? image;
  String? token;

  UserData.fromJson(Map<String,dynamic> json){
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }
}