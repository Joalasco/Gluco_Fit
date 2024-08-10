class Receta {
  final String recetaID;
  final String nombre;
  final String descripcion;
  final String region;
  final String categoriaID;
  final int tiempoPreparacion;
  final List<String> instrucciones;
  final Map<String, dynamic> ingredientes;
  final String imagenURL;

  Receta({
    required this.recetaID,
    required this.nombre,
    required this.descripcion,
    required this.region,
    required this.categoriaID,
    required this.tiempoPreparacion,
    required this.instrucciones,
    required this.ingredientes,
    required this.imagenURL,
  });

  // Método para crear una instancia de Receta desde un documento de Firestore
  factory Receta.fromFirestore(Map<String, dynamic> data) {
    return Receta(
      recetaID: data['recetaID'],
      nombre: data['nombre'],
      descripcion: data['descripcion']['detalle'],
      region: data['descripcion']['región'],
      categoriaID: data['categoriaID'],
      tiempoPreparacion: data['tiempoPreparacion'],
      instrucciones: List<String>.from(data['instrucciones']),
      ingredientes: Map<String, dynamic>.from(data['ingredientes']),
      imagenURL: data['imagenURL'],
    );
  }
}
