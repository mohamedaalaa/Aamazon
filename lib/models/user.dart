import 'package:amazon/models/product.dart';

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
    required this.cart,
  });

  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String id;
  final String v;
  final String token;
  List<dynamic> cart;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        type: json["type"],
        id: json["_id"],
        v: json["__v"].toString(),
        token: json["token"] ?? "",
        cart: List<dynamic>.from(
            json['cart'].map((x) => Map<String, dynamic>.from(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "address": address,
        "type": type,
        "_id": id,
        "__v": v,
        "token": token,
        'cart': cart
      };
}

// List<Map<String, dynamic>> get userCarts {
//   return getUser.cart.from();
// }

UserModel _user = UserModel(
  name: '',
  email: '',
  password: '',
  address: '',
  type: '',
  id: '',
  v: '',
  token: '',
  cart: [],
);

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
      token: user.token,
      cart: user.cart);

  print(_user.type);
  print(_user.cart);
}

void setUserCart({required List<dynamic> cart}) {
  _user.cart = cart;

  print(_user.cart);
}
