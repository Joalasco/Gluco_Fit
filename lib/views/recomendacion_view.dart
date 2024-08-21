import 'package:flutter/material.dart';

class RecomendacionView extends StatelessWidget {
  final String title;

  RecomendacionView({required this.title});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD1F3E7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Bienvenid@ de vuelta, Name',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Desayuno'),
                _buildMealRow(
                  'lib/assets/tostada_aguacate.jpeg',
                  'Tostada de aguacate',
                  secondImage: 'lib/assets/tostada_aguacate.jpeg',
                  secondTitle: 'Tostada de aguacate',
                ),
                _buildSectionTitle('Almuerzo'),
                _buildMealRow(
                  'lib/assets/tostada_aguacate.jpeg',
                  'Tostada de aguacate',
                  secondImage: 'lib/assets/ensalada_verde.jpeg',
                  secondTitle: 'Ensalada verde',
                ),
                _buildSectionTitle('Merienda'),
                _buildMealRow(
                  'lib/assets/ensalada_verde.jpeg',
                  'Ensalada verde',
                  secondImage: 'lib/assets/ensalada_verde.jpg',
                  secondTitle: 'Ensalada verde',
                ),
              ],
            ),
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
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildMealRow(String imagePath, String title,
      {String? secondImage, String? secondTitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildRecommendationItem(imagePath, title, '2 servings'),
        if (secondImage != null && secondTitle != null)
          _buildRecommendationItem(secondImage, secondTitle, '2 servings'),
      ],
    );
  }

  Widget _buildRecommendationItem(
      String imagePath, String title, String servings) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 120,
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
              textAlign: TextAlign.center,
            ),
            Text(
              servings,
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}