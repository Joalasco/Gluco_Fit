import 'package:cloud_firestore/cloud_firestore.dart'; // Para Firestore
import '../models/comment_model.dart'; // Asegúrate de que la ruta sea correcta

class ComentarioController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Agregar un nuevo comentario a una receta
  Future<void> agregarComentario(Comentario comentario) async {
    try {
      await _firestore.collection('comentarios').add(comentario.toMap());
    } catch (e) {
      print('Error al agregar comentario: $e');
    }
  }

  // Obtener los comentarios de una receta específica
  Future<List<Comentario>> obtenerComentariosPorReceta(String recetaID) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('comentarios')
          .where('recetaID', isEqualTo: recetaID)
          .orderBy('fecha', descending: true)
          .get();

      return snapshot.docs.map((doc) => Comentario.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error al obtener comentarios: $e');
      return [];
    }
  }
}
