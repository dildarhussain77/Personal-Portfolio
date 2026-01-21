import '../models/project_model.dart';

List<Project> getProjects() {
  return [
    Project(
      id: '1',
      title: 'Flutter Web Portfolio',
      description: 'A responsive personal portfolio website built using Flutter Web to showcase projects, skills, and experience, with smooth animations and resume access.',
      githubUrl: 'https://github.com/dildarhussain77/Personal-Portfolio',
      liveUrl: 'https://example.com',
      technologies: ['Flutter Web', 'Dart', 'Formspree', 'Responsive UI'],
      features: [
        'Fully responsive design for all screen sizes',
        'Smooth fade and slide animations',
        'Project showcase with detailed cards',
        'Contact form integration',
        'View and download resume functionality',
      ],
      imagePath: 'assets/images/project1.png',
    ),
    Project(
      id: '2',
      title: 'Eye Care Reminder App',
      description: 'A Flutter application with native Android integration that reminds users to follow the 20-20-20 eye care rule using background services and scheduled notifications.',
      githubUrl: 'https://github.com/dildarhussain77/eye_care_reminder',
      liveUrl: null,
      technologies: ['Flutter', 'Kotlin', 'WorkManager', 'Foreground Service'],
      features: [
        '20-20-20 eye care reminder notifications',
        'Foreground service for reliable background execution',
        'Screen ON/OFF detection',
        'Battery-optimized scheduling using WorkManager',
        'Flutter to Android communication via platform channels',
      ],
      imagePath: 'assets/images/pic3.png',
    ),
    Project(
      id: '3',
      title: 'Weather App',
      description: 'A Flutter-based weather application that displays real-time weather information using the OpenWeatherMap API with clean UI and error handling.',
      githubUrl: 'https://github.com/dildarhussain77/Weather_App',
      liveUrl: 'https://taskmanager.example.com',
      technologies: ['Flutter', 'Dart', 'REST API', 'OpenWeatherMap API'],
      features: [
        'Real-time weather data',
        'City-based search functionality',
        'Graceful error handling',
        'Smooth and responsive user interface',
      ],
      imagePath: 'assets/images/project3.png',
    ),
    Project(
      id: '4',
      title: 'AlzRelief (Final Year Project)',
      description: 'A Flutter-based mobile application designed to support Alzheimer’s patients and caregivers by providing therapeutic activities and access to professional psychologists.',
      githubUrl: 'https://github.com/dildarhussain77/flutter_AlzRelief',
      liveUrl: 'https://taskmanager.example.com',
      technologies: ['Flutter', 'Dart', 'Firebase Authentication', 'Cloud Firestore'],
      features: [
        'Secure authentication with Google Sign-In',
        'Journaling and task management modules',
        'Music therapy and interactive activities',
        'Basic personal finance tracking',
        'Firebase-backed real-time data management',
      ],
      imagePath: 'assets/images/project3.png',
    ),
  ];
}