// screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:pethub/models/postOnHomepage/postOnHomepage_model.dart';
import 'package:pethub/widgets/postOnHomepage/postOnHomepage_widget.dart';

class HomePage extends StatelessWidget {
  final List<PostModel> posts = [
    PostModel(
      title: 'Wow!',
      date: DateTime.now(),
      breed: 'Golden Retriever',
      imageUrl: 'assets/images/dog_1.jpg',
      location: 'Wrocław',
    ),
    PostModel(
      title: 'What a dog',
      date: DateTime.now(),
      breed: 'Siamese',
      imageUrl: 'assets/images/shiba.png',
      location: 'Wrocław',
    ),
    PostModel(
      title: 'Looking for a Dog Walker',
      date: DateTime.now(),
      breed: 'Labrador',
      imageUrl: 'assets/images/dog_2.png',
      location: 'Wrocław',
    ),
    // Dodaj więcej postów, jeśli chcesz
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Posts'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.9, 
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: posts[index]);
        },
      ),
    );
  }
}