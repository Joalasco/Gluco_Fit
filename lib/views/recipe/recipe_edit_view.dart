import 'package:flutter/material.dart';
import '../../models/recipe_model.dart';
import '../../controllers/recipe_controller.dart';

class RecipeEditView extends StatefulWidget {
  final Recipe recipe;

  RecipeEditView({required this.recipe});

  @override
  _RecipeEditViewState createState() => _RecipeEditViewState();
}

class _RecipeEditViewState extends State<RecipeEditView> {
  final _formKey = GlobalKey<FormState>();
  final RecipeController _controller = RecipeController();
  
  late TextEditingController _nombreController;
  late TextEditingController _descripcionDetalleController;
  late TextEditingController _descripcionRegionController;
  late TextEditingController _tiempoPreparacionController;
  late TextEditingController _imagenURLController;
  late List<TextEditingController> _instruccionesControllers;
  late Map<String, List<Map<String, TextEditingController>>> _ingredientesControllers;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.recipe.nombre);
    _descripcionDetalleController = TextEditingController(text: widget.recipe.descripcion.detalle);
    _descripcionRegionController = TextEditingController(text: widget.recipe.descripcion.region);
    _tiempoPreparacionController = TextEditingController(text: widget.recipe.tiempoPreparacion.toString());
    _imagenURLController = TextEditingController(text: widget.recipe.imagenURL);
    
    _instruccionesControllers = widget.recipe.instrucciones
        .map((instruccion) => TextEditingController(text: instruccion))
        .toList();
    
    _ingredientesControllers = {
      'frutas': _initIngredientControllers(widget.recipe.ingredientes.frutas),
      'lacteos': _initIngredientControllers(widget.recipe.ingredientes.lacteos),
      'proteinas': _initIngredientControllers(widget.recipe.ingredientes.proteinas),
      'verduras': _initIngredientControllers(widget.recipe.ingredientes.verduras),
      'semillas': _initIngredientControllers(widget.recipe.ingredientes.semillas),
    };
  }

  List<Map<String, TextEditingController>> _initIngredientControllers(List<Ingrediente>? ingredientes) {
    return ingredientes?.map((ingrediente) => {
      'nombre': TextEditingController(text: ingrediente.nombre),
      'cantidad': TextEditingController(text: ingrediente.cantidad.toString()),
      'unidad': TextEditingController(text: ingrediente.unidad),
      'calorias': TextEditingController(text: ingrediente.informacionNutricional.calorias.toString()),
      'grasas': TextEditingController(text: ingrediente.informacionNutricional.grasas.toString()),
      'proteinas': TextEditingController(text: ingrediente.informacionNutricional.proteinas.toString()),
      'carbohidratos': TextEditingController(text: ingrediente.informacionNutricional.carbohidratos.toString()),
      'glucosa': TextEditingController(text: ingrediente.informacionNutricional.glucosa.toString()),
    }).toList() ?? [];
  }

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

  Future<void> _updateRecipe() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final updatedRecipe = Recipe(
        recetaID: widget.recipe.recetaID,
        nombre: _nombreController.text,
        descripcion: Descripcion(
          detalle: _descripcionDetalleController.text,
          region: _descripcionRegionController.text
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
        await _controller.updateRecipe(updatedRecipe);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar la receta: $e')),
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
      appBar: AppBar(title: Text('Editar Receta')),
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
              onPressed: _updateRecipe,
              child: Text('Actualizar Receta'),
            ),
          ],
        ),
      ),
    );
  }
}
