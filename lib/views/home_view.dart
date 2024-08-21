import 'package:flutter/material.dart';
import 'package:gluco_fit/views/menu/menu_list.dart';
import '../controllers/auth_controller.dart';
import 'recipe/recipe_list_view.dart';
import 'auth_view.dart';
import '../services/recipe_upload_service.dart'; 

class HomeView extends StatelessWidget {
  final AuthController _authController = AuthController();
  final RecipeUploadService _uploadService = RecipeUploadService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD1F3E7),
      appBar: AppBar(
        title: Text('Menú Principal'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await _authController.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AuthView()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bienvenid@ de vuelta, Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset('lib/assets/glucofit_logo.jpeg',
                      fit: BoxFit.contain),
                ),
              ),
              SizedBox(height: 30),
              _buildMenuItem(Icons.lock, 'Feedback'),
              SizedBox(height: 15),
              _buildMenuItem(Icons.question_answer, 'FAQ'),
              SizedBox(height: 15),
              _buildMenuItem(Icons.book, 'Recursos educativos'),
              SizedBox(height: 15),

              // Botón pequeño para subir recetas
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await _uploadService.uploadRecipesFromFile(
                        'lib/assets/resources/recetasSierra.txt');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Recetas subidas correctamente')),
                    );
                  },
                  child: Text('Subir Recetas'),
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    textStyle: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu), label: 'Recetas'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menús'),
          BottomNavigationBarItem(
              icon: Icon(Icons.recommend), label: 'Recomendaciones'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecipeListView()),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecipesOfTheDayScreen()),
            );
          }
          // Aquí puedes agregar la lógica para las otras opciones del menú
        },
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey),
            SizedBox(width: 16),
            Text(title, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
