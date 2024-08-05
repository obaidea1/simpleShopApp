
class LoginModel {
   String? msg;
   bool? status;
   UserData? userData;

   LoginModel({this.userData,this.status,this.msg});
  LoginModel.fromJson(Map<String,dynamic> json){
    msg = json['message'] ;
    status = json['status'] ;
    userData = json['data'] != null ? UserData.fromJson(json: json['data']) : null;
  }
}

class UserData {
   int? id;
   String? name;
   String? phone;
   String? email;
   String? image;
   int? points;
   int? credit;
   String? token;

   UserData ({this.name,this.phone,this.image,this.id,this.credit,this.email,this.points,this.token});

  UserData.fromJson({required Map<String, dynamic> json}){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
