class UserModel{
  late String userId;
  late String imgLink;
  late String name;
  late String email;
  late bool online;

  UserModel.fromJson(Map<String,dynamic>json){
    userId = json["userId"];
    imgLink = json["image"];
    name = json["name"];
    email = json["email"];
    online = json["online"];
  }

  Map<String,dynamic> toMap(){
    return {
      'userId':userId,
      'email':email,
      'name':name,
      'online':online,
      'image':imgLink,
    };
  }
}