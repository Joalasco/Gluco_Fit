import 'package:flutter/material.dart';
import '../../controllers/recipe_controller.dart';
import '../../models/recipe_model.dart';

class RecipeEditView extends StatefulWidget {
  final Recipe recipe;

  RecipeEditView({required this.recipe});

  @override
  _RecipeEditViewState createState() => _RecipeEditViewState();
}

class _RecipeEditViewState extends State<RecipeEditView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _ingredientsController;
  late TextEditingController _instructionsController;

  final RecipeController controller = RecipeController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.recipe.title);
    _descriptionController = TextEditingController(text: widget.recipe.description);
    _ingredientsController = TextEditingController(text: widget.recipe.ingredients.join(', '));
    _instructionsController = TextEditingController(text: widget.recipe.instructions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Receta')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa un título';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextFormField(
              controller: _ingredientsController,
              decoration: InputDecoration(labelText: 'Ingredientes (separados por coma)'),
            ),
            TextFormField(
              controller: _instructionsController,
              decoration: InputDecoration(labelText: 'Instrucciones'),
              maxLines: 3,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    await controller.updateRecipe(
                      id: widget.recipe.id,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      ingredients: _ingredientsController.text.split(',').map((e) => e.trim()).toList(),
                      instructions: _instructionsController.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Receta actualizada con éxito')),
                    );
                    Navigator.pop(context, true); // Retorna true para indicar que se hicieron cambios
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al actualizar la receta: $e')),
                    );
                  }
                }
              },
              child: Text('Actualizar Receta'),
            ),
          ],
        ),
      ),
    );
  }
}