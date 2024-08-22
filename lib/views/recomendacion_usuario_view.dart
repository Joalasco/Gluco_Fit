import 'package:flutter/material.dart';

class RecomendacionUsuarioView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD1F3E7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
        title: Text(
          'Menús',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.green[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Recomendaciones',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildMenuItem(
                    'lib/assets/ensalada_aguacate.jpeg',
                    'Ensalada de aguacate',
                    true,
                  ),
                  _buildMenuItem(
                    'lib/assets/ensalada_aguacate.jpeg',
                    'Ensalada de pollo',
                    false,
                  ),
                  _buildMenuItem(
                    'lib/assets/ensalada_aguacate.jpeg',
                    'Ensalada de aguacate',
                    true,
                  ),
                ],
              ),
            ),
          ],
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
          // Lógica para la navegación del BottomNavigationBar
        },
      ),
    );
  }

  Widget _buildMenuItem(String imagePath, String title, bool isRecommended) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text('Descripción',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              Text('Tiempo de preparación',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('Calorías totales',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('Grasas totales',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('Proteínas totales',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('Carbohidratos totales',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isRecommended ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              isRecommended ? 'Si se recomienda' : 'No se recomienda',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
