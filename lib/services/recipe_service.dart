import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recipe_model.dart';

class RecipeService {
  final CollectionReference _recipesCollection = FirebaseFirestore.instance.collection('recipes');

  Future<List<Recipe>> getRecipes() async {
    QuerySnapshot snapshot = await _recipesCollection.get();
    return snapshot.docs.map((doc) => Recipe.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<void> createRecipe(Recipe recipe) async {
    await _recipesCollection.doc(recipe.id).set(recipe.toMap());
  }

  Future<void> updateRecipe(Recipe recipe) async {
    await _recipesCollection.doc(recipe.id).update(recipe.toMap());
  }

  Future<void> deleteRecipe(String id) async {
    await _recipesCollection.doc(id).delete();
  }
}