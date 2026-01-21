import 'package:flutter/material.dart';

class Education {
  final String id;
  final String degree;
  final String institution;
  final String duration;
  final String location;
  final String? gpa;
  final List<String> highlights;
  // final Color color;
  final String? institutionLogoPath;

  Education({
    required this.id,
    required this.degree,
    required this.institution,
    required this.duration,
    required this.location,
    required this.highlights,
    // required this.color,
    this.gpa,
    this.institutionLogoPath,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'],
      degree: json['degree'],
      institution: json['institution'],
      duration: json['duration'],
      location: json['location'],
      gpa: json['gpa'],
      highlights: List<String>.from(json['highlights']),
      // color: Color(json['color']),
      institutionLogoPath: json['institutionLogoPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'degree': degree,
      'institution': institution,
      'duration': duration,
      'location': location,
      'gpa': gpa,
      'highlights': highlights,
      // 'color': color.value,
      'institutionLogoPath': institutionLogoPath,
    };
  }
}