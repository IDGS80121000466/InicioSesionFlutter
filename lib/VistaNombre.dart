import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EditarNombre.dart';
import 'main.dart';

class VistaNombre extends StatelessWidget {
  final String nombre;

  const VistaNombre({super.key, required this.nombre});

  
  void mostrarVistaEditar(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VistaEditar(nombre: nombre)),
    );
  }

  void eliminarNombre(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('nombre');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(title: 'Inicio de Sesión')),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Nombre Guardado'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              nombre,
              style: TextStyle(fontSize: 24),
            ),
             SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => mostrarVistaEditar(context),
              child: Text('Editar Nombre'),
            ),
             SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => eliminarNombre(context),
              child: Text('Eliminar Nombre'),
            ),
          ],
        ),
      ),
    );
  }
}