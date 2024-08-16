import 'package:flutter/material.dart';
import '../../controllers/recipe_controller.dart';
import '../../models/recipe_model.dart';
import '../../services/preference_service.dart';
import '../../models/preference_model.dart';
import 'recipe_detail_view.dart';
import 'recipe_create_view.dart';

class RecipeListView extends StatefulWidget {
  @override
  _RecipeListViewState createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView> {
  final RecipeController controller = RecipeController();
  final PreferenceService _preferenceService = PreferenceService();
  List<Recipe> recipes = [];
  bool isLoading = true;
  String selectedRegion = 'Sierra';
  late UserPreferences userPreferences;

  @override
  void initState() {
    super.initState();
    _loadPreferencesAndRecipes();
  }

  Future _loadPreferencesAndRecipes() async {
    try {
      userPreferences = await _preferenceService.getUserPreferences();
      selectedRegion = userPreferences.favoriteRegions.isNotEmpty 
          ? userPreferences.favoriteRegions.first 
          : 'Sierra';
      await _loadRecipes();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar preferencias: $e')),
      );
    }
  }

  Future _loadRecipes() async {
    try {
      final loadedRecipes = await controller.getRecipes();
      setState(() {
        recipes = loadedRecipes.where((recipe) {
          return recipe.region == selectedRegion &&
                 _recipeMatchesPreferences(recipe);
        }).toList();
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

  bool _recipeMatchesPreferences(Recipe recipe) {
    if (!userPreferences.likesFrutas && recipe.ingredientes.frutas?.isNotEmpty == true) return false;
    if (!userPreferences.likesVerduras && recipe.ingredientes.verduras?.isNotEmpty == true) return false;
    if (!userPreferences.likesLacteos && recipe.ingredientes.lacteos?.isNotEmpty == true) return false;
    if (!userPreferences.likesProteinas && recipe.ingredientes.proteinas?.isNotEmpty == true) return false;
    if (!userPreferences.likesSemillas && recipe.ingredientes.semillas?.isNotEmpty == true) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F2E9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Recetas', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipeCreateView()),
              ).then((_) => _loadRecipes());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildRegionTabs(),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : _buildRecipeGrid(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildRegionTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ['Sierra', 'Costa'].map((region) {
          return ElevatedButton(
            child: Text(region),
            onPressed: () {
              setState(() {
                selectedRegion = region;
                _loadRecipes();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedRegion == region ? Colors.green : Colors.grey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRecipeGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return _buildRecipeCard(recipe);
      },
    );
  }

  Widget _buildRecipeCard(Recipe recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailView(recipe: recipe),
          ),
        ).then((_) => _loadRecipes());
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(recipe.imagenURL),
            ),
            SizedBox(height: 10),
            Text(recipe.nombre, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(recipe.descripcion.detalle, style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Recetas'),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menús'),
        BottomNavigationBarItem(icon: Icon(Icons.recommend), label: 'Recomendaciones'),
      ],
    );
  }
}