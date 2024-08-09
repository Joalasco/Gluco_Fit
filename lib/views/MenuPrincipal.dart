import 'package:flutter/material.dart';

class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD1F3E7),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Bienvenid@ de vuelta, Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Image.asset('assets/glucofit_logo.png', width: 150),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Feedback'),
              onTap: () {
                // Handle feedback tap
              },
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('FAQ'),
              onTap: () {
                // Handle FAQ tap
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Recursos educativos'),
              onTap: () {
                // Handle educational resources tap
              },
            ),
            Spacer(),
            BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Recetas'),
                BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menús'),
                BottomNavigationBarItem(icon: Icon(Icons.recommend), label: 'Recomendaciones'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}