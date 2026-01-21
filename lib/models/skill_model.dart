import 'package:flutter/material.dart';

class Skill {
  final String id;
  final String name;
  final String iconPath;
  final Color color;
  final String category;

  Skill({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.color,
    required this.category,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      name: json['name'],
      iconPath: json['iconPath'],
      color: Color(json['color']),
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconPath': iconPath,
      'color': color.value,
      'category': category,
    };
  }
}