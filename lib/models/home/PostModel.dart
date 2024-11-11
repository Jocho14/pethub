import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String title;
  final DateTime date;
  final String breed;
  final String imageUrl;
  final String location;
  final String description;  // Dodajemy nowe pole dla opisu

  
  PostModel({
    required this.title,
    required this.date,
    required this.breed,
    required this.imageUrl,
    required this.location,
    required this.description, // Dodajemy parametr dla opisu
  });

  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return PostModel(
      title: data['title'],
      date: (data['date'] as Timestamp).toDate(),
      breed: data['breed'],
      imageUrl: data['imageUrl'],
      location: data['location'],
      description: data['description'] ?? 'No description available', // Domyślny tekst, jeśli brak opisu
    );
  }
}