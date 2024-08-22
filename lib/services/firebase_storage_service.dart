import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload a file to Firebase Storage
  Future<String> uploadFile(File file, String folder) async {
    try {
      final fileName = path.basename(file.path);
      final destination = '$folder/$fileName';
      final ref = _storage.ref(destination);
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading file: $e');
      return '';
    }
  }

  // Retrieve the download URL of a file
  Future<String> getFileUrl(String filePath) async {
    try {
      final ref = _storage.ref(filePath);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error getting file URL: $e');
      return '';
    }
  }

  // Delete a file from Firebase Storage
  Future<bool> deleteFile(String filePath) async {
    try {
      final ref = _storage.ref(filePath);
      await ref.delete();
      return true;
    } catch (e) {
      print('Error deleting file: $e');
      return false;
    }
  }

  // List all files in a specific folder
  Future<List<String>> listFiles(String folder) async {
    try {
      final ListResult result = await _storage.ref(folder).listAll();
      return result.items.map((item) => item.fullPath).toList();
    } catch (e) {
      print('Error listing files: $e');
      return [];
    }
  }

  // Upload a video file (potentially with different handling)
  Future<String> uploadVideo(File videoFile, String folder) async {
    // You might want to add additional logic here, like compressing the video
    return await uploadFile(videoFile, folder);
  }
}