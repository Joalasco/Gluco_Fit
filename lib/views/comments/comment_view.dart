import 'package:flutter/material.dart';
import '../../controllers/comment_controller.dart';
import '../../models/comment_model.dart';
import '../../models/recipe_model.dart';

class ComentariosView extends StatefulWidget {
  final Recipe receta;

  ComentariosView({required this.receta});

  @override
  _ComentariosViewState createState() => _ComentariosViewState();
}

class _ComentariosViewState extends State<ComentariosView> {
  final ComentarioController _comentarioController = ComentarioController();
  final TextEditingController _comentarioControllerTexto = TextEditingController();
  List<Comentario> _comentarios = [];

  @override
  void initState() {
    super.initState();
    _cargarComentarios();
  }

  void _cargarComentarios() async {
    List<Comentario> comentarios = await _comentarioController.obtenerComentariosPorReceta(widget.receta.recetaID);
    setState(() {
      _comentarios = comentarios;
    });
  }

  void _agregarComentario() async {
    if (_comentarioControllerTexto.text.isNotEmpty) {
      Comentario nuevoComentario = Comentario(
        comentarioID: '',
        recetaID: widget.receta.recetaID,
        usuarioID: 'usuarioEjemploID', // Este ID debería ser el ID del usuario autenticado
        texto: _comentarioControllerTexto.text,
        fecha: DateTime.now(),
        nombreUsuario: 'Nombre del Usuario', // Este valor debería ser obtenido del usuario autenticado
      );

      await _comentarioController.agregarComentario(nuevoComentario);
      _comentarioControllerTexto.clear();
      _cargarComentarios();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _comentarios.length,
            itemBuilder: (context, index) {
              Comentario comentario = _comentarios[index];
              return ListTile(
                title: Text(comentario.nombreUsuario),
                subtitle: Text(comentario.texto),
                trailing: Text('${comentario.fecha.toLocal()}'),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _comentarioControllerTexto,
            decoration: InputDecoration(
              hintText: 'Agrega un comentario...',
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: _agregarComentario,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
