import 'package:flutter/material.dart';
import '../../models/recipe_model.dart';
import '../../controllers/recipe_controller.dart';
import 'recipe_edit_view.dart';

class RecipeDetailView extends StatefulWidget {
  final Recipe recipe;

  RecipeDetailView({required this.recipe});

  @override
  _RecipeDetailViewState createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView> {
  final RecipeController controller = RecipeController();
  late Recipe _recipe;

  @override
  void initState() {
    super.initState();
    _recipe = widget.recipe;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_recipe.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeEditView(recipe: _recipe),
                ),
              );
              if (result == true) {
                // Si se realizaron cambios, vuelve a la lista de recetas
                Navigator.pop(context, true);
              } else {
                // Si no se realizaron cambios, actualiza la vista con los datos del widget
                setState(() {
                  _recipe = widget.recipe;
                });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Eliminar Receta'),
                  content: Text('¿Estás seguro de que quieres eliminar esta receta?'),
                  actions: [
                    TextButton(
                      child: Text('Cancelar'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: Text('Eliminar'),
                      onPressed: () async {
                        try {
                          await controller.deleteRecipe(_recipe.id);
                          Navigator.pop(context); // Cerrar el diálogo
                          Navigator.pop(context, true); // Volver a la lista de recetas indicando cambios
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error al eliminar la receta: $e')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Descripción:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_recipe.description),
            SizedBox(height: 16),
            Text('Ingredientes:', style: TextStyle(fontWeight: FontWeight.bold)),
            ..._recipe.ingredients.map((ingredient) => Text('• $ingredient')),
            SizedBox(height: 16),
            Text('Instrucciones:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_recipe.instructions),
          ],
        ),
      ),
    );
  }
}