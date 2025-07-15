
import 'package:ecommerce_flutter/domain/models/Role.dart';

class User {
    int id;
    String name;
    String lastname;
    String email;
    String phone;
    String image;
    dynamic notificationToken;
    List<Role> roles;

    User({
        required this.id,
        required this.name,
        required this.lastname,
        required this.email,
        required this.phone,
        required this.image,
        required this.notificationToken,
        required this.roles,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        notificationToken: json["notification_token"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "image": image,
        "notification_token": notificationToken,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
    };
}