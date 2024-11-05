// screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:pethub/models/postOnHomepage/postOnHomepage_model.dart';
import 'package:pethub/widgets/postOnHomepage/postOnHomepage_widget.dart';

class HomePage extends StatelessWidget {
  final List<PostModel> posts = [
    PostModel(
      title: 'Adopt a Friendly Dog',
      date: DateTime.now(),
      breed: 'Golden Retriever',
      imageUrl: 'assets/images/dog_1.jpg',
    ),
    PostModel(
      title: 'Need a Cat Sitter',
      date: DateTime.now(),
      breed: 'Siamese',
      imageUrl: 'assets/images/cat_1.png',
    ),
    PostModel(
      title: 'Looking for a Dog Walker',
      date: DateTime.now(),
      breed: 'Labrador',
      imageUrl: 'assets/images/dog_2.png',
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
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75, // Ustaw proporcje kafelków
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: posts[index]);
        },
      ),
    );
  }
}