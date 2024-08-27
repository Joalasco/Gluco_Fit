import 'package:flutter/material.dart';
import 'detalles_educativo_view.dart'; // Importa la nueva vista de detalles

class EducativoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Educación'),
        backgroundColor: Colors.lightGreen,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Colors.lightGreen[50],
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            _buildCard(
              context,
              'Que es el ayuno',
              'Tiempo de preparación\nCalorías totales\nGrasas totales\nProteínas totales\nCarbohidratos totales',
              'assets/ayuno.png',
            ),
            SizedBox(height: 16.0),
            _buildCard(
              context,
              'Días de dieta',
              'Tiempo de preparación\nCalorías totales\nGrasas totales\nProteínas totales\nCarbohidratos totales',
              'assets/dieta.png',
            ),
            SizedBox(height: 16.0),
            _buildCard(
              context,
              'Calorías en alimentos',
              'Tiempo de preparación\nCalorías totales\nGrasas totales\nProteínas totales\nCarbohidratos totales',
              'assets/calorias.png',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.lightGreen,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Recetas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menús',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recommend),
            label: 'Recomendaciones',
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String description, String imagePath) {
    return GestureDetector(
      onTap: () {
        // Navega a la pantalla de detalles cuando se hace clic en la tarjeta
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetallesEducativoView(
              title: title,
              description: description,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
