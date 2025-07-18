import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    int? id;
    int id_category;
    String name;
    String description;
    double price;
    String? image1;
    String ?image2;

    Product({
        this.id,
        required this.id_category,
        required this.name,
        required this.description,
        required this.price,
        this.image1,
        this.image2,
    });

    static List<Product>fromJsonList(List<dynamic> jsonList) {
        List<Product> toList = [];
        jsonList.forEach((item) {
          Product product = Product.fromJson(item);
          toList.add(product);
         
        });
        return toList;
    }

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        id_category: json["id_category"] is String ? int.parse(json["id_category"]) : json["id_category"],
        name: json["name"] ?? '',
        description: json["description"] ?? '',
        price: json["price"] is String ? double.parse(json["price"]) : json["price"] is int ? json["price"].toDouble() : json["price"],
        image1: json["image1"],
        image2: json["image2"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_category": id_category,
        "name": name,
        "description": description,
        "price": price,
        "image1": image1,
        "image2": image2,
    };
}
