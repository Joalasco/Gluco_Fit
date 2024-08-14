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
  String selectedRegion = 'Sierra';

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future _loadRecipes() async {
    try {
      final loadedRecipes = await controller.getRecipes();
      setState(() {
        recipes = loadedRecipes.where((recipe) => recipe.region == selectedRegion).toList();
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
        children: [
          ElevatedButton(
            child: Text('Sierra'),
            onPressed: () {
              setState(() {
                selectedRegion = 'Sierra';
                _loadRecipes();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedRegion == 'Sierra' ? Colors.green : Colors.grey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
          ElevatedButton(
            child: Text('Costa'),
            onPressed: () {
              setState(() {
                selectedRegion = 'Costa';
                _loadRecipes();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedRegion == 'Costa' ? Colors.green : Colors.grey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ],
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
              backgroundImage: NetworkImage(recipe.imagenURL), // You might want to replace this with actual recipe image
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