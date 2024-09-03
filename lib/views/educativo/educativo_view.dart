import 'package:flutter/material.dart';
import '../../services/recurso_educativo_service.dart';
import '../../models/recurso_educativo_model.dart';
import 'detalles_educativo_view.dart';

class EducativoView extends StatelessWidget {
  final RecursoEducativoService _recursoService = RecursoEducativoService();

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
      body: FutureBuilder<List<RecursoEducativo>>(
        future: _recursoService.getRecursosEducativos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error cargando recursos educativos.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text('No hay recursos educativos disponibles.'));
          }

          final recursos = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: recursos.length,
            itemBuilder: (context, index) {
              final recurso = recursos[index];
              return _buildCard(
                context,
                recurso.descripcion,
                recurso.imageUrl,
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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

  Widget _buildCard(BuildContext context, String description, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetallesEducativoView(
              title: description,
              description: description,
              imagePath: imageUrl,
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
              Image.network(
                imageUrl,
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
                      description,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Ver más detalles...',
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
