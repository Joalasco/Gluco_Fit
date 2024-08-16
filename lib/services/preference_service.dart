import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/preference_model.dart';

class PreferenceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveUserPreferences(UserPreferences preferences) async {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      await _firestore.collection('user_preferences').doc(userId).set(preferences.toMap());
    } else {
      throw Exception('No user logged in');
    }
  }

  Future<UserPreferences> getUserPreferences() async {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      final doc = await _firestore.collection('user_preferences').doc(userId).get();
      if (doc.exists) {
        return UserPreferences.fromMap(doc.data()!);
      } else {
        // Si no existen preferencias, crea unas por defecto
        final defaultPreferences = UserPreferences();
        await saveUserPreferences(defaultPreferences);
        return defaultPreferences;
      }
    }
    throw Exception('No user logged in');
  }
}