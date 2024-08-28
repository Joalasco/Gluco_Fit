class RecursoEducativo {
  final String id;
  final String descripcion;
  final String imageUrl;

  RecursoEducativo({
    required this.id,
    required this.descripcion,
    required this.imageUrl,
  });

  // Método para crear una instancia de RecursoEducativo desde un documento de Firestore
  factory RecursoEducativo.fromFirestore(Map<String, dynamic> data, String id) {
    return RecursoEducativo(
      id: id,
      descripcion: data['descripcion'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}
