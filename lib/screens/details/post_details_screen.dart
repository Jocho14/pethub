// screens/post_details_page.dart
import 'package:flutter/material.dart';
import 'package:pethub/models/home/PostModel.dart';

class PostDetailsPage extends StatelessWidget {
  final PostModel post;

  PostDetailsPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title), // Tytuł to tytuł ogłoszenia
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Zdjęcie ogłoszenia
              Image.network(post.imageUrl),
              SizedBox(height: 16),

              // Tytuł ogłoszenia
              Text(
                post.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),

              // Data ogłoszenia
              Text(
                'Posted on: ${post.date.toLocal()}'.split(' ')[0],
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 16),

              // Rasa zwierzęcia
              Text(
                'Breed: ${post.breed}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),

              // Lokalizacja
              Text(
                'Location: ${post.location}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),

              // Wyświetlanie opisu
              Text(
                'Description:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                post.description, // Wyświetlamy pobrany opis
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

