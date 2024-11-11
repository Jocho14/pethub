import 'package:flutter/material.dart';
import 'package:pethub/models/postOnHomepage/postOnHomepage_model.dart';

class PostProvider extends ChangeNotifier {
  final List<PostModel> posts = [
    PostModel(
      title: 'Wow!',
      date: DateTime.now(),
      breed: 'Doge',
      imageUrl: 'assets/images/dog_1.jpg',
      location: 'Wrocław',
    ),
    PostModel(
      title: 'Cat care available',
      date: DateTime.now().add(Duration(days: 1)),
      breed: 'Persian',
      imageUrl: 'assets/images/cat_1.png',
      location: 'Wrocław',
    ),
  ];

  void addPost(PostModel post) {
    posts.add(post);
    notifyListeners();
  }

  // Możesz dodać więcej metod, np. do usuwania postów, edytowania itp.
}
