import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/recurso_educativo_model.dart';

class RecursoEducativoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtener todos los recursos educativos
  Future<List<RecursoEducativo>> getRecursosEducativos() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection('recursos_educativos').get();
      return snapshot.docs.map((doc) {
        return RecursoEducativo.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print('Error obteniendo recursos educativos: $e');
      return [];
    }
  }
}
