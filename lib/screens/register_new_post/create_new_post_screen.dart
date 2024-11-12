import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pethub/models/home/PostModel.dart';
import 'package:provider/provider.dart';
import 'package:pethub/providers/auth/auth_provider.dart';

class AddPostPage extends StatefulWidget {
  final Function refreshPosts;

  AddPostPage({required this.refreshPosts});

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _titleController = TextEditingController();
  final _breedController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();

  // Funkcja do zapisania ogłoszenia w Firestore
  Future<void> _addPost() async {
    final currentUserId =
        Provider.of<AuthProvider>(context, listen: false).user?.uid;

    if (currentUserId == null) {
      // Handle the case where there is no logged-in user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You must be logged in to post!")),
      );
      return;
    }

    final post = {
      'title': _titleController.text,
      'breed': _breedController.text,
      'location': _locationController.text,
      'description': _descriptionController.text,
      'imageUrl': _imageUrlController.text,
      'date': Timestamp.now(),
      'userId': currentUserId,
    };

    // Zapisz dane w kolekcji Firestore
    await FirebaseFirestore.instance.collection('animals').add(post);

    // Po dodaniu ogłoszenia, wywołaj metodę refreshPosts, aby odświeżyć HomePage
    widget.refreshPosts();

    // Powróć do poprzedniego ekranu
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _breedController,
              decoration: InputDecoration(labelText: 'Breed'),
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPost,
              child: Text('Add Post'),
            ),
          ],
        ),
      ),
    );
  }
}
