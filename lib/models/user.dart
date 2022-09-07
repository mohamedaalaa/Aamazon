class UserModel {
  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.id,
    required this.v,
    required this.token,
  });

  String name;
  String email;
  String password;
  String address;
  String type;
  String id;
  String v;
  String token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        type: json["type"],
        id: json["_id"],
        v: json["__v"].toString(),
        token: json["token"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "address": address,
        "type": type,
        "_id": id,
        "__v": v,
        "token": token
      };
}

UserModel _user = UserModel(
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    id: '',
    v: '',
    token: '');

UserModel get getUser => _user;

void setUser(UserModel user) {
  _user = UserModel(
      name: user.name,
      email: user.email,
      password: user.password,
      address: user.address,
      type: user.type,
      id: user.id,
      v: user.v,
      token: user.token);

  print(_user.type);
}
