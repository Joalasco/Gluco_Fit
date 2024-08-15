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
      backgroundColor: Color(0xFFD1F3E7), // Fondo verde claro
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(_recipe.nombre, style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black),
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
            icon: Icon(Icons.delete, color: Colors.black),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              _recipe.imagenURL,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descripción:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(_recipe.descripcion.detalle),
                  Text('Región: ${_recipe.descripcion.region}'),
                  SizedBox(height: 16),
                  Text(
                    'Tiempo de Preparación:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text('${_recipe.tiempoPreparacion} minutos'),
                  SizedBox(height: 16),
                  Text(
                    'Ingredientes:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  _buildIngredientList(_recipe.ingredientes),
                  SizedBox(height: 16),
                  Text(
                    'Instrucciones:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  ..._recipe.instrucciones.map((step) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text('• $step'),
                  )),
                ],
              ),
            ),
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