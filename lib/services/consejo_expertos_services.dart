import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/consejo_expertos_model.dart';

class ConsejoExpertoService {
  final CollectionReference _consejosRef =
      FirebaseFirestore.instance.collection('consejos_expertos');

  // Obtener todos los consejos de expertos
  Future<List<ConsejoExperto>> getConsejos() async {
    try {
      final QuerySnapshot snapshot = await _consejosRef.get();
      return snapshot.docs
          .map((doc) => ConsejoExperto.fromMap(
              doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error al obtener los consejos de expertos: $e');
      return [];
    }
  }

  // Agregar un nuevo consejo de experto
  Future<void> addConsejo(ConsejoExperto consejo) async {
    try {
      await _consejosRef.add(consejo.toMap());
    } catch (e) {
      print('Error al agregar el consejo de experto: $e');
    }
  }

  // Obtener un consejo de experto por ID
  Future<ConsejoExperto?> getConsejoById(String id) async {
    try {
      final DocumentSnapshot doc = await _consejosRef.doc(id).get();
      if (doc.exists) {
        return ConsejoExperto.fromMap(
            doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      print('Error al obtener el consejo de experto: $e');
      return null;
    }
  }

  // Actualizar un consejo de experto por ID
  Future<void> updateConsejo(ConsejoExperto consejo) async {
    try {
      await _consejosRef.doc(consejo.id).update(consejo.toMap());
    } catch (e) {
      print('Error al actualizar el consejo de experto: $e');
    }
  }

  // Eliminar un consejo de experto por ID
  Future<void> deleteConsejo(String id) async {
    try {
      await _consejosRef.doc(id).delete();
    } catch (e) {
      print('Error al eliminar el consejo de experto: $e');
    }
  }
}
