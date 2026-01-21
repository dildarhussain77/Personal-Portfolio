import 'package:flutter/material.dart';

class Experience {
  final String id;
  final String company;
  final String role;
  final String duration;
  final String location;
  final String description;
  final List<String> technologies;
  final List<String> achievements;
  // final Color color;
  final String? companyLogoPath;

  Experience({
    required this.id,
    required this.company,
    required this.role,
    required this.duration,
    required this.location,
    required this.description,
    required this.technologies,
    required this.achievements,
    // required this.color,
    this.companyLogoPath,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'],
      company: json['company'],
      role: json['role'],
      duration: json['duration'],
      location: json['location'],
      description: json['description'],
      technologies: List<String>.from(json['technologies']),
      achievements: List<String>.from(json['achievements']),
      // color: Color(json['color']),
      companyLogoPath: json['companyLogoPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'role': role,
      'duration': duration,
      'location': location,
      'description': description,
      'technologies': technologies,
      'achievements': achievements,
      // 'color': color.value,
      'companyLogoPath': companyLogoPath,
    };
  }
}