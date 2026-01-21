import 'package:flutter/material.dart';
import '../models/experience_model.dart';

List<Experience> getExperiences() {
  return [
    Experience(
      id: '1',
      company: 'Veroke',
      role: 'Mobile App Developer',
      duration: 'August 2025 - Present',
      location: 'on-site',
      description: 'Working as a Mobile Application Developer with a focus on native Android development using Java and Kotlin, while actively contributing to Flutter-based projects in line with evolving organizational requirements.',
      technologies: ['Android Native', 'Flutter', 'Firebase', 'REST APIs'],
      achievements: [
        'Developed native Android applications using Java and Kotlin, while contributing to Flutter-based projects.',
        'Implemented clean UI components, integrated backend services, and improved application stability.',
        'Collaborated with designers, backend developers, and QA teams to deliver scalable, maintainable mobile solutions.',
        'Implemented clean architecture in all projects'
      ],
    ),
    Experience(
      id: '2',
      company: 'Veroke',
      role: 'Android Development Intern',
      duration: 'April 2025 - July 2025',
      location: 'on-site',
      description: 'Completed an Android Development internship at Veroke, gaining hands-on experience in building, testing, and debugging Android applications in a real-world development environment..',
      technologies: ['Android Development', 'Kotlin', 'Firebase', 'Java', 'REST APIs'],
      achievements: [
        'Gained real-world experience in building, testing, and debugging Android applications',
        'Developed UI components and handled application logic using Java and Kotlin',
        'Learned version control workflows, team collaboration, and professional development practices under senior guidance'
      ],
    ),
  ];
}