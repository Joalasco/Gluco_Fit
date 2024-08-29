class Comentario {
  final String comentarioID;
  final String recetaID;
  final String usuarioID;
  final String texto;
  final DateTime fecha;
  final String nombreUsuario; // Mantén el nombre de usuario

  Comentario({
    required this.comentarioID,
    required this.recetaID,
    required this.usuarioID,
    required this.texto,
    required this.fecha,
    required this.nombreUsuario,
  });

  factory Comentario.fromMap(Map<String, dynamic> map) {
    return Comentario(
      comentarioID: map['comentarioID'] ?? '',
      recetaID: map['recetaID'] ?? '',
      usuarioID: map['usuarioID'] ?? '',
      texto: map['texto'] ?? '',
      fecha: DateTime.parse(map['fecha'] ?? DateTime.now().toIso8601String()),
      nombreUsuario: map['nombreUsuario'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comentarioID': comentarioID,
      'recetaID': recetaID,
      'usuarioID': usuarioID,
      'texto': texto,
      'fecha': fecha.toIso8601String(),
      'nombreUsuario': nombreUsuario,
    };
  }
}
