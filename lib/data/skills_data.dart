import 'package:flutter/material.dart';
import '../models/skill_model.dart';

List<Skill> getSkills() {
  return [
    Skill(
      id: '1',
      name: 'Dart',
      iconPath: 'assets/icons/dart.png',
      color: const Color(0xFF00B4AB),
      category: 'Language',
    ),
    Skill(
      id: '2',
      name: 'Java',
      iconPath: 'assets/icons/java.png',
      color: const Color(0xFFEA4335),
      category: 'Language',
    ),
    Skill(
      id: '3',
      name: 'Kotlin',
      iconPath: 'assets/icons/kotlin.png',
      color: const Color(0xFF7F52FF),
      category: 'Language',
    ),
    Skill(
      id: '4',
      name: 'Android Native',
      iconPath: 'assets/icons/android.png',
      color: const Color(0xFF3DDC84),
      category: 'Framework',
    ),
    Skill(
      id: '5',
      name: 'Flutter',
      iconPath: 'assets/icons/flutter.png',
      color: const Color(0xFF02569B),
      category: 'Framework',
    ),
    Skill(
      id: '6',
      name: 'Firebase',
      iconPath: 'assets/icons/firebase.png',
      color: const Color(0xFFFFCA28),
      category: 'Backend',
    ),
    Skill(
      id: '7',
      name: 'REST APIs',
      iconPath: 'assets/icons/api.png',
      color: const Color(0xFF34A853),
      category: 'Backend',
    ),

    Skill(
      id: '8',
      name: 'Git',
      iconPath: 'assets/icons/git.png',
      color: const Color(0xFFF1502F),
      category: 'Tools',
    ),
    Skill(
      id: '9',
      name: 'GitHub',
      iconPath: 'assets/icons/github.png',
      color: const Color(0xFF333333),
      category: 'Tools',
    ),
    Skill(
      id: '10',
      name: 'Android Studio',
      iconPath: 'assets/icons/androidStudio.png',
      color: const Color(0xFF3DDC84),
      category: 'Tools',
    ),
    Skill(
      id: '11',
      name: 'VS Code',
      iconPath: 'assets/icons/vsCode.png',
      color: const Color(0xFF007ACC),
      category: 'Tools',
    ),
  ];
}