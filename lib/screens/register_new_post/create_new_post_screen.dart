import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pethub/models/home/PostModel.dart';
import 'package:provider/provider.dart';
import 'package:pethub/providers/auth/auth_provider.dart';
import 'dart:io';
import 'dart:typed_data'; // For Uint8List
import 'package:flutter/foundation.dart'; // For kIsWeb

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
  XFile? _imageFile;
  Uint8List? _webImageData; // For web image data
  bool _isUploading = false;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (kIsWeb) {
        // For web, get the image bytes
        _webImageData = await pickedFile.readAsBytes();
      }
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<String?> _uploadImage(XFile image) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('post_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask;
      if (kIsWeb) {
        // For web, use putData
        uploadTask = storageRef.putData(_webImageData!);
      } else {
        // For mobile, use putFile
        uploadTask = storageRef.putFile(File(image.path));
      }
      final snapshot = await uploadTask.whenComplete(() => {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> _addPost() async {
    final currentUserId =
        Provider.of<AuthProvider>(context, listen: false).user?.uid;

    if (currentUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You must be logged in to post!")),
      );
      return;
    }

    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select an image!")),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    final imageUrl = await _uploadImage(_imageFile!);

    if (imageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to upload image!")),
      );
      setState(() {
        _isUploading = false;
      });
      return;
    }

    final post = {
      'title': _titleController.text,
      'breed': _breedController.text,
      'location': _locationController.text,
      'description': _descriptionController.text,
      'imageUrl': imageUrl,
      'date': Timestamp.now(),
      'userId': currentUserId,
    };

    await FirebaseFirestore.instance.collection('animals').add(post);

    widget.refreshPosts();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget imagePreview;
    if (_imageFile != null) {
      if (kIsWeb && _webImageData != null) {
        // For web, display the image using Image.memory
        imagePreview = Image.memory(_webImageData!);
      } else {
        // For mobile, display the image using Image.file
        imagePreview = Image.file(File(_imageFile!.path));
      }
    } else {
      imagePreview = TextButton.icon(
        onPressed: _pickImage,
        icon: Icon(Icons.image),
        label: Text('Pick Image'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            imagePreview,
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            _isUploading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _addPost,
                    child: Text('Add Post'),
                  ),
          ],
        ),
      ),
    );
  }
}
