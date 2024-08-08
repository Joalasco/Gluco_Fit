import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../controllers/auth_controller.dart';
import '../models/user_model.dart';
import 'register_view.dart';
import '../views/recipe/recipe_list_view.dart';

class AuthView extends StatefulWidget {
  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final AuthController _authController = AuthController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  User? _currentUser;
  bool _isFirebaseConnected = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkFirebaseConnection();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    print('Iniciando _loadCurrentUser');
    try {
      print('Llamando a _authController.getCurrentUser()');
      final user = await _authController.getCurrentUser();
      print('Usuario obtenido: ${user?.email}');
      setState(() {
        _currentUser = user;
        _isLoading = false;
      });
      print('Estado actualizado, _isLoading: $_isLoading');
    } catch (e) {
      print('Error al cargar el usuario: $e');
      setState(() {
        _currentUser = null;
        _isLoading = false;
      });
    }
  }

  Future<void> _checkFirebaseConnection() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _isFirebaseConnected = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Conexión exitosa a Firebase'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() {
        _isFirebaseConnected = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al conectar con Firebase: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _updateCurrentUser() async {
    final user = await _authController.getCurrentUser();
    setState(() {
      _currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Auth MVC Demo'),
        actions: [
          if (_currentUser != null)
            IconButton(
              icon: Icon(Icons.restaurant_menu),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecipeListView()),
                );
              },
            ),
          Icon(
            _isFirebaseConnected ? Icons.cloud_done : Icons.cloud_off,
            color: _isFirebaseConnected ? Colors.green : Colors.red,
          ),
        ],
      ),
      drawer: _currentUser != null
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text('Menú'),
                  ),
                  ListTile(
                    title: Text('Recetas'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecipeListView()),
                      );
                    },
                  ),
                ],
              ),
            )
          : null,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_currentUser == null) ...[
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Contraseña'),
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterView()),
                        );
                      },
                      child: Text('Ir a Registro'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final user = await _authController.signIn(
                            _emailController.text,
                            _passwordController.text,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Inicio de sesión exitoso')),
                          );
                          await _updateCurrentUser();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error en el inicio de sesión: $e')),
                          );
                        }
                      },
                      child: Text('Iniciar sesión'),
                    ),
                  ] else ...[
                    Text('Usuario actual: ${_currentUser!.email}'),
                    Text('Nombre: ${_currentUser!.nombre}'),
                    Text('Edad: ${_currentUser!.edad}'),
                    Text('Género: ${_currentUser!.genero}'),
                    Text('Creado el: ${_currentUser!.createdAt.toString()}'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RecipeListView()),
                        );
                      },
                      child: Text('Ver Recetas'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        await _authController.signOut();
                        await _updateCurrentUser();
                      },
                      child: Text('Cerrar sesión'),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}