import 'package:flutter/material.dart';
import '../../controllers/recipe_controller.dart';

class RecipeCreateView extends StatefulWidget {
  @override
  _RecipeCreateViewState createState() => _RecipeCreateViewState();
}

class _RecipeCreateViewState extends State<RecipeCreateView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();

  final RecipeController controller = RecipeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Recipe')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _ingredientsController,
              decoration: InputDecoration(labelText: 'Ingredients (comma-separated)'),
            ),
            TextFormField(
              controller: _instructionsController,
              decoration: InputDecoration(labelText: 'Instructions'),
              maxLines: 3,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  controller.createRecipe(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    ingredients: _ingredientsController.text.split(','),
                    instructions: _instructionsController.text,
                  );
                  Navigator.pop(context);
                }
              },
              child: Text('Create Recipe'),
            ),
          ],
        ),
      ),
    );
  }
}