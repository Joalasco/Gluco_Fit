import 'package:flutter/material.dart';

class ConsejosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consejos de Salud'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Consejos para una Vida Saludable',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 16),
            _buildConsejoCard(
              'Bebe suficiente agua',
              'Mantenerse hidratado es crucial para la salud en general. Trata de beber al menos 8 vasos de agua al día.',
              Icons.local_drink,
            ),
            SizedBox(height: 16),
            _buildConsejoCard(
              'Incorpora frutas y verduras',
              'Las frutas y verduras son esenciales en una dieta equilibrada. Intenta incluirlas en cada comida.',
              Icons.local_florist,
            ),
            SizedBox(height: 16),
            _buildConsejoCard(
              'Ejercicio Regular',
              'Hacer ejercicio regularmente ayuda a mantener un peso saludable y reduce el riesgo de enfermedades.',
              Icons.fitness_center,
            ),
            SizedBox(height: 16),
            _buildConsejoCard(
              'Duerme bien',
              'Dormir entre 7-8 horas por noche es fundamental para el bienestar físico y mental.',
              Icons.bedtime,
            ),
            SizedBox(height: 16),
            _buildConsejoCard(
              'Recetas saludables',
              'Explora nuestras recetas saludables para complementar estos consejos y mantener una dieta equilibrada.',
              Icons.restaurant_menu,
              onTap: () {
                Navigator.pushNamed(context, '/recetas');
              },
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
            icon: Icon(Icons.receipt),
            label: 'Recetas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Menús',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recommend),
            label: 'Recomendaciones',
          ),
        ],
        currentIndex: 3, // Asegura que "Recomendaciones" esté seleccionado
        selectedItemColor: Colors.teal,
        onTap: (index) {
          // Manejo de la navegación según el índice seleccionado
        },
      ),
    );
  }

  Widget _buildConsejoCard(String title, String description, IconData icon,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.teal,
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
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
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
