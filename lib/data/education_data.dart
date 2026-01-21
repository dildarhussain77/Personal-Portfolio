import 'package:flutter/material.dart';
import '../models/education_model.dart';

List<Education> getEducation() {
  return [
    Education(
      id: '1',
      degree: 'Bachelor of Science in Software Engineering',
      institution: 'NUML Islamabad',
      duration: 'Feb 2021 - Feb 2025',
      location: 'Islamabad, Pakistan',
      gpa: '3.0/4.0',
      highlights: [
        'Focused on software development and mobile applications',
        'Studied programming, databases, and system design concepts',
      ],
      // color: const Color(0xFF4285F4),
    ),
    Education(
      id: '2',
      degree: 'Intermediate (Pre-Engineering)',
      institution: 'Aspire Group of College, Lahore',
      duration: '2018 - 2020',
      location: 'Lahore, Pakistan',
      gpa: 'A Grade',
      highlights: [
        'Strong foundation in mathematics and science subjects',
        'Developed analytical thinking and problem-solving skills',
      ],
      // color: const Color(0xFFE57373),
    ),
    Education(
      id: '3',
      degree: 'Matriculation (Science)',
      institution: 'FG Boys School, Sialkot cantt',
      duration: '2016 - 2018',
      location: 'Sialkot, Pakistan',
      gpa: 'A+ Grade',
      highlights: [
        'Studied core science subjects with computer fundamentals',
        'Gained early exposure to basic programming concepts in C programming language',
      ],
      // color: const Color(0xFF4285F4),
    ),
  ];
}