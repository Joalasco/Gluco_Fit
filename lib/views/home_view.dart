import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'recipe/recipe_list_view.dart';
import 'auth_view.dart';
import '../services/recipe_upload_service.dart';
import 'recomendacion_view.dart'; // Importa la nueva vista

class HomeView extends StatelessWidget {
  final AuthController _authController = AuthController();
  final RecipeUploadService _uploadService = RecipeUploadService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD1F3E7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0, // Oculta el AppBar
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Text(
                'Bienvenid@ de vuelta, Name',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset('lib/assets/glucofit_logo.jpeg',
                      fit: BoxFit.contain),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuItem(Icons.lock, 'Feedback'),
                  _buildMenuItem(Icons.question_answer, 'FAQ'),
                ],
              ),
              SizedBox(height: 15),
              _buildMenuItem(Icons.book, 'Recursos educativos', isCentered: true),
              SizedBox(height: 30),
              Text(
                'Recomendaciones del día',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildRecommendationItem('lib/assets/ensalada_verde.jpg',
                        'Ensalada verde', '2 servings', context),
                    _buildRecommendationItem('lib/assets/ensalada_verde.jpeg',
                        'Ensalada verde', '2 servings', context),
                    // Agrega más recomendaciones si es necesario
                  ],
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
          // Aquí puedes agregar la lógica para las otras opciones del menú
        },
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {bool isCentered = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment:
            isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey),
          if (!isCentered) SizedBox(width: 16),
          Text(title, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(
      String imagePath, String title, String servings, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecomendacionView(title: title)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: 150,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              servings,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
