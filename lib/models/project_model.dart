class Project {
  final String id;
  final String title;
  final String description;
  final String githubUrl;
  final String? liveUrl;
  final List<String> technologies;
  final List<String> features;
  final String? imagePath;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.githubUrl,
    this.liveUrl,
    required this.technologies,
    required this.features,
    this.imagePath,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      githubUrl: json['githubUrl'],
      liveUrl: json['liveUrl'],
      technologies: List<String>.from(json['technologies']),
      features: List<String>.from(json['features']),
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'githubUrl': githubUrl,
      'liveUrl': liveUrl,
      'technologies': technologies,
      'features': features,
      'imagePath': imagePath,
    };
  }
}