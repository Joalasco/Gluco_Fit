import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RecommendationScreen(),
    );
  }
}

class RecommendationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menús'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recomendaciones',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            SizedBox(height: 16),
            _buildMenuItem(
              image: 'assets/aguacate.jpg',
              title: 'Ensalada de aguacate',
              recommended: true,
            ),
            _buildMenuItem(
              image: 'assets/pollo.jpg',
              title: 'Ensalada de pollo',
              recommended: false,
            ),
            _buildMenuItem(
              image: 'assets/aguacate.jpg',
              title: 'Ensalada de aguacate',
              recommended: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Recetas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
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

  Widget _buildMenuItem({
    required String image,
    required String title,
    required bool recommended,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Descripción',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Text(
                  'Tiempo de preparación\nCalorías totales\nGrasas totales\nProteínas totales\nCarbohidratos totales',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: recommended ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              recommended ? 'Sí se recomienda' : 'No se recomienda',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
