import 'package:flutter/material.dart';

class FoodRecipe {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String? icon;

  FoodRecipe({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.icon,
    required this.id,
  });

  factory FoodRecipe.fromJson(Map<String, dynamic> toMap) {
    return FoodRecipe(
      id: toMap['id'],
      name: toMap['name'],
      description: toMap['description'],
      imageUrl: toMap['imageUrl'],
      icon: toMap['icon.codePoint']??'',
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'icon': icon!,
    };
  }
}
