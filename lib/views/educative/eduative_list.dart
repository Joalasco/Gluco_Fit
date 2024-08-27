import 'package:flutter/material.dart';

class EducationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB5F1CC),
      appBar: AppBar(
        title: Text('Educación', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
            },
          ),
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildEducationCard(
            'Que es el ayuno',
            'Descripción\nAutores\nInformación importante\nInformación nutricional\nObservaciones',
            'lib/assets/glucofit_logo.jpeg',
          ),
          SizedBox(height: 16),
          _buildEducationCard(
            'Días de dieta',
            'Descripción\nAutores\nInformación importante\nInformación nutricional\nObservaciones',
            'lib/assets/glucofit_logo.jpeg',
          ),
          SizedBox(height: 16),
          _buildEducationCard(
            'Calorías en alimentos',
            'Descripción\nAutores\nInformación importante\nInformación nutricional\nObservaciones',
            'lib/assets/glucofit_logo.jpeg',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Recetas'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Menús'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Educación'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildEducationCard(String title, String description, String imagePath) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  height: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}