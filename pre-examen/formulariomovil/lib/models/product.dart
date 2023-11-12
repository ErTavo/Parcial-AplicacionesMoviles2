// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    bool available;
    String name;
    String picture;
    double price;
    String? id;

    Product({
        required this.available,
        required this.name,
        required this.picture,
        required this.price,
        this.id,
    });

    Product copyWith({
        bool? available,
        String? name,
        String? picture,
        String? price,
        int? id,
    }) => 
        Product(
            available: available ?? this.available,
            name: name ?? this.name,
            picture: picture ?? this.picture,
            price: this.price,
            id:  this.id,
        );

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));
    String toJson() => json.encode(toMap());
    factory Product.fromMap(Map<String, dynamic> json) => Product(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"]
    );

    Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price
    };
}
