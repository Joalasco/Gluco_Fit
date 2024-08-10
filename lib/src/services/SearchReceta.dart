import 'package:cloud_firestore/cloud_firestore.dart';
import 'receta.dart'; // Asegúrate de que este archivo contiene la clase Receta.

class RecetaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Receta>> buscarRecetasPorCategoria(String categoriaID) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('recetas')
          .where('categoriaID', isEqualTo: categoriaID)
          .get();

      return snapshot.docs.map((doc) {
        return Receta.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception('Error al buscar recetas: $e');
    }
  }

  Future<Receta?> buscarRecetaPorID(String recetaID) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('recetas').doc(recetaID).get();

      if (doc.exists) {
        return Receta.fromFirestore(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error al buscar receta: $e');
    }
  }

  Future<List<Receta>> buscarRecetasPorRegion(String region) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('recetas')
          .where('descripcion.región', isEqualTo: region)
          .get();

      return snapshot.docs.map((doc) {
        return Receta.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception('Error al buscar recetas: $e');
    }
  }
}
