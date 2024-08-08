import '../models/recipe_model.dart';
import '../services/recipe_service.dart';

class RecipeController {
  final RecipeService _service = RecipeService();

  Future<List<Recipe>> getRecipes() async {
    return await _service.getRecipes();
  }

  Future<void> createRecipe({
    required String title,
    required String description,
    required List<String> ingredients,
    required String instructions,
  }) async {
    final recipe = Recipe(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      ingredients: ingredients,
      instructions: instructions,
      userId: 'current_user_id', // Replace with actual user ID
    );
    await _service.createRecipe(recipe);
  }

  Future<void> updateRecipe({
    required String id,
    required String title,
    required String description,
    required List<String> ingredients,
    required String instructions,
  }) async {
    final recipe = Recipe(
      id: id,
      title: title,
      description: description,
      ingredients: ingredients,
      instructions: instructions,
      userId: 'current_user_id', // Replace with actual user ID
    );
    await _service.updateRecipe(recipe);
  }

  Future<void> deleteRecipe(String id) async {
    await _service.deleteRecipe(id);
  }
}