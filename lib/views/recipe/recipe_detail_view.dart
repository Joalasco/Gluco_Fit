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
  late Recipe _recipe = widget.recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_recipe.nombre),
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
                Navigator.pop(context, true);
              } else {
                setState(() {});
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
                          await controller.deleteRecipe(_recipe.recetaID);
                          Navigator.pop(context);
                          Navigator.pop(context, true);
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
            Text(_recipe.descripcion.detalle),
            Text('Región: ${_recipe.descripcion.region}'),
            SizedBox(height: 16),
            Text('Tiempo de Preparación:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('${_recipe.tiempoPreparacion} minutos'),
            SizedBox(height: 16),
            Text('Ingredientes:', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildIngredientList(_recipe.ingredientes),
            SizedBox(height: 16),
            Text('Instrucciones:', style: TextStyle(fontWeight: FontWeight.bold)),
            ..._recipe.instrucciones.map((step) => Text('• $step')),
            SizedBox(height: 16),
            Image.network(_recipe.imagenURL, height: 200, width: double.infinity, fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientList(Ingredientes ingredientes) {
    List<Widget> ingredientWidgets = [];
    
    void addIngredients(String category, List<Ingrediente>? ingredients) {
      if (ingredients != null && ingredients.isNotEmpty) {
        ingredientWidgets.add(Text(category, style: TextStyle(fontWeight: FontWeight.bold)));
        ingredientWidgets.addAll(ingredients.map((i) => Text('• ${i.nombre}: ${i.cantidad} ${i.unidad}')));
      }
    }

    addIngredients('Frutas', ingredientes.frutas);
    addIngredients('Lácteos', ingredientes.lacteos);
    addIngredients('Proteínas', ingredientes.proteinas);
    addIngredients('Verduras', ingredientes.verduras);
    addIngredients('Semillas', ingredientes.semillas);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: ingredientWidgets);
  }
}