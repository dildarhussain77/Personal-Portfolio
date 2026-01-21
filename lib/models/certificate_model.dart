import 'package:flutter/material.dart';

class Certificate {
  final String id;
  final String title;
  final String issuer;
  final String issueDate;
  final String? expiryDate;
  // final String credentialId;
  final String url;
  // final Color color;
  final String? badgePath;

  Certificate({
    required this.id,
    required this.title,
    required this.issuer,
    required this.issueDate,
    this.expiryDate,
    // required this.credentialId,
    required this.url,
    // required this.color,
    this.badgePath,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      id: json['id'],
      title: json['title'],
      issuer: json['issuer'],
      issueDate: json['issueDate'],
      expiryDate: json['expiryDate'],
      // credentialId: json['credentialId'],
      url: json['url'],
      // color: Color(json['color']),
      badgePath: json['badgePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'issuer': issuer,
      'issueDate': issueDate,
      'expiryDate': expiryDate,
      // 'credentialId': credentialId,
       'url': url,
      // 'color': color.value,
      'badgePath': badgePath,
    };
  }
}