// To parse this JSON data, do
//
//     final getModel = getModelFromMap(jsonString);

import 'dart:convert';


GetModel getModelFromMap(String str) => GetModel.fromMap(json.decode(str));

String getModelToMap(GetModel data) => json.encode(data.toMap());

class GetModel {
  GetModel({
     this.name,
     this.email,
     this.city,
     this.gender,
     this.image,
  });

  String? name;
  String? email;
  String? city;
  String? gender;
  String? image;

  factory GetModel.fromMap(Map<String, dynamic> json) => GetModel(
    name: json["name"],
    email: json["email"],
    city: json["city"],
    gender: json["gender"],
    image: json["imageUrl"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "email": email,
    "city": city,
    "gender": gender,
    "imageUrl": image,
  };
}
