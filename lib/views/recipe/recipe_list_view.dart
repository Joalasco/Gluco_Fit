import 'package:flutter/material.dart';
import '../../controllers/recipe_controller.dart';
import '../../models/recipe_model.dart';
import 'recipe_detail_view.dart';
import 'recipe_create_view.dart';

class RecipeListView extends StatefulWidget {
  @override
  _RecipeListViewState createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView> {
  final RecipeController controller = RecipeController();
  List<Recipe> recipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    try {
      final loadedRecipes = await controller.getRecipes();
      setState(() {
        recipes = loadedRecipes;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar las recetas: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis Recetas')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return ListTile(
                  title: Text(recipe.nombre),
                  subtitle: Text(recipe.descripcion.detalle),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailView(recipe: recipe),
                      ),
                    ).then((_) => _loadRecipes());
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RecipeCreateView()),
          ).then((_) => _loadRecipes());
        },
      ),
    );
  }
}