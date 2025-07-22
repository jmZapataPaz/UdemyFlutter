import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
    int? id;
    int idUser;
    String address;
    String neighborhood;

    Address({
        this.id,
        required this.idUser,
        required this.address,
        required this.neighborhood,
    });

    static List<Address>fromJsonList(List<dynamic> jsonList) {
        List<Address> toList = [];
        jsonList.forEach((item) {
          Address category = Address.fromJson(item);
          toList.add(category);
         
        });
        return toList;
    }    

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        idUser: json["id_user"],
        address: json["address"],
        neighborhood: json["neighborhood"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "address": address,
        "neighborhood": neighborhood,
    };
}
