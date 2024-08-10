import 'package:flutter/material.dart';
import '../../models/recipe_model.dart';
import '../../controllers/recipe_controller.dart';
import 'package:uuid/uuid.dart';

class RecipeCreateView extends StatefulWidget {
  @override
  _RecipeCreateViewState createState() => _RecipeCreateViewState();
}

class _RecipeCreateViewState extends State<RecipeCreateView> {
  final _formKey = GlobalKey<FormState>();
  final RecipeController _controller = RecipeController();

  final _nombreController = TextEditingController();
  final _descripcionDetalleController = TextEditingController();
  final _descripcionRegionController = TextEditingController();
  final _tiempoPreparacionController = TextEditingController();
  final _imagenURLController = TextEditingController();

  List<TextEditingController> _instruccionesControllers = [TextEditingController()];

  Map<String, List<Map<String, TextEditingController>>> _ingredientesControllers = {
    'frutas': [],
    'lacteos': [],
    'proteinas': [],
    'verduras': [],
    'semillas': [],
  };

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionDetalleController.dispose();
    _descripcionRegionController.dispose();
    _tiempoPreparacionController.dispose();
    _imagenURLController.dispose();
    for (var controller in _instruccionesControllers) {
      controller.dispose();
    }
    for (var category in _ingredientesControllers.values) {
      for (var ingredientControllers in category) {
        ingredientControllers.values.forEach((controller) => controller.dispose());
      }
    }
    super.dispose();
  }

  void _addInstruction() {
    setState(() {
      _instruccionesControllers.add(TextEditingController());
    });
  }

  void _removeInstruction(int index) {
    setState(() {
      _instruccionesControllers[index].dispose();
      _instruccionesControllers.removeAt(index);
    });
  }

  void _addIngredient(String category) {
    setState(() {
      _ingredientesControllers[category]!.add({
        'nombre': TextEditingController(),
        'cantidad': TextEditingController(),
        'unidad': TextEditingController(),
        'calorias': TextEditingController(),
        'grasas': TextEditingController(),
        'proteinas': TextEditingController(),
        'carbohidratos': TextEditingController(),
        'glucosa': TextEditingController(),
      });
    });
  }

  void _removeIngredient(String category, int index) {
    setState(() {
      _ingredientesControllers[category]![index].values.forEach((controller) => controller.dispose());
      _ingredientesControllers[category]!.removeAt(index);
    });
  }

  Future<void> _createRecipe() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newRecipe = Recipe(
        recetaID: Uuid().v4(),
        nombre: _nombreController.text,
        descripcion: Descripcion(
          detalle: _descripcionDetalleController.text,
          region: _descripcionRegionController.text,
        ),
        tiempoPreparacion: int.tryParse(_tiempoPreparacionController.text) ?? 0,
        instrucciones: _instruccionesControllers
            .map((controller) => controller.text)
            .where((text) => text.isNotEmpty)
            .toList(),
        ingredientes: Ingredientes(
          frutas: _buildIngredientesList('frutas'),
          lacteos: _buildIngredientesList('lacteos'),
          proteinas: _buildIngredientesList('proteinas'),
          verduras: _buildIngredientesList('verduras'),
          semillas: _buildIngredientesList('semillas'),
        ),
        imagenURL: _imagenURLController.text,
      );

      try {
        await _controller.createRecipe(newRecipe);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear la receta: $e')),
        );
      }
    }
  }

  List<Ingrediente>? _buildIngredientesList(String category) {
    final ingredientes = _ingredientesControllers[category]!
        .map((controllers) => Ingrediente(
              nombre: controllers['nombre']!.text,
              cantidad: int.tryParse(controllers['cantidad']!.text) ?? 0,
              unidad: controllers['unidad']!.text,
              informacionNutricional: InformacionNutricional(
                calorias: double.tryParse(controllers['calorias']!.text) ?? 0,
                grasas: double.tryParse(controllers['grasas']!.text) ?? 0,
                proteinas: double.tryParse(controllers['proteinas']!.text) ?? 0,
                carbohidratos: double.tryParse(controllers['carbohidratos']!.text) ?? 0,
                glucosa: double.tryParse(controllers['glucosa']!.text) ?? 0,
              ),
            ))
        .toList();
    return ingredientes.isNotEmpty ? ingredientes : null;
  }

  Widget _buildIngredientFields(String category, int index) {
    final controllers = _ingredientesControllers[category]![index];
    return ExpansionTile(
      title: Text(controllers['nombre']!.text.isEmpty ? 'Nuevo Ingrediente' : controllers['nombre']!.text),
      children: [
        TextFormField(
          controller: controllers['nombre'],
          decoration: InputDecoration(labelText: 'Nombre'),
        ),
        TextFormField(
          controller: controllers['cantidad'],
          decoration: InputDecoration(labelText: 'Cantidad'),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          controller: controllers['unidad'],
          decoration: InputDecoration(labelText: 'Unidad'),
        ),
        TextFormField(
          controller: controllers['calorias'],
          decoration: InputDecoration(labelText: 'Calorías'),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          controller: controllers['grasas'],
          decoration: InputDecoration(labelText: 'Grasas'),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          controller: controllers['proteinas'],
          decoration: InputDecoration(labelText: 'Proteínas'),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          controller: controllers['carbohidratos'],
          decoration: InputDecoration(labelText: 'Carbohidratos'),
          keyboardType: TextInputType.number,
        ),
        TextFormField(
          controller: controllers['glucosa'],
          decoration: InputDecoration(labelText: 'Glucosa'),
          keyboardType: TextInputType.number,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () => _removeIngredient(category, index),
            child: Text('Eliminar Ingrediente'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Nueva Receta')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
              validator: (value) => value!.isEmpty ? 'Por favor ingrese un nombre' : null,
            ),
            TextFormField(
              controller: _descripcionDetalleController,
              decoration: InputDecoration(labelText: 'Descripción'),
              validator: (value) => value!.isEmpty ? 'Por favor ingrese una descripción' : null,
            ),
            TextFormField(
              controller: _descripcionRegionController,
              decoration: InputDecoration(labelText: 'Región'),
            ),
            TextFormField(
              controller: _tiempoPreparacionController,
              decoration: InputDecoration(labelText: 'Tiempo de Preparación (minutos)'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Por favor ingrese el tiempo de preparación' : null,
            ),
            ..._instruccionesControllers.asMap().entries.map(
              (entry) => Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: entry.value,
                      decoration: InputDecoration(labelText: 'Instrucción ${entry.key + 1}'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeInstruction(entry.key),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _addInstruction,
              child: Text('Agregar Instrucción'),
            ),
            ..._ingredientesControllers.entries.map((entry) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.key.toUpperCase(), style: Theme.of(context).textTheme.titleLarge),
                ...entry.value.asMap().entries.map((ingredientEntry) => 
                  _buildIngredientFields(entry.key, ingredientEntry.key)
                ),
                ElevatedButton(
                  onPressed: () => _addIngredient(entry.key),
                  child: Text('Agregar ${entry.key}'),
                ),
              ],
            )),
            TextFormField(
              controller: _imagenURLController,
              decoration: InputDecoration(labelText: 'URL de la Imagen'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createRecipe,
              child: Text('Crear Receta'),
            ),
          ],
        ),
      ),
    );
  }
}
