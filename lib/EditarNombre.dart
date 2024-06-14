import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'VistaNombre.dart';

class VistaEditar extends StatefulWidget {
  final String nombre;

  const VistaEditar({super.key, required this.nombre});

  @override
  State<VistaEditar> createState() => EstadoEditarNombre();
}

class EstadoEditarNombre extends State<VistaEditar> {
  late TextEditingController controladorNombre;

  @override
  void initState() {
    super.initState();
    controladorNombre = TextEditingController(text: widget.nombre);
  }

  void guardarNombreEditado() async {
  if (controladorNombre.text.isNotEmpty) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombre', controladorNombre.text);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => VistaNombre(nombre: controladorNombre.text)),
      (Route<dynamic> route) => false,
    );
  } else {
    final snackBar = SnackBar(
      content: const Text('Debe ingresar un nombre para poder editar'),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

  
  void eliminarNombre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('nombre');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Inicio de Sesión')),
      (Route<dynamic> route) => false,
    );
  }

  void cancelarEdicion() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Editar Nombre'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controladorNombre,
                keyboardType: TextInputType.text, //habre el teclado en texto
                textAlign: TextAlign.center, // centra el texto
                maxLength: 30, // maximo 30 caracteres
                obscureText: false, // true oculta el texto
                autofocus: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.people),// pone un icono antes de la caja de texto
                  // prefix: Icon(Icons.catching_pokemon)// pone un icono dentro de la caja de texto
                  helperText: "Edita tu nombre", // Pone texto abajo de la caja
                  border: OutlineInputBorder(), // pone borde al texto
                  hintText: "Escribe aquí tu nuevo nombre",//Pone texto dentro de la caja de texto
                  fillColor: Colors.green, filled: true, //Pone color a la caja de texto
                ),
                style: TextStyle(
                 color: Colors.black, // Pone el texto color negro
                  fontWeight: FontWeight.bold,  // Pone el texto en negritas  
                ),
              ),
               SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: cancelarEdicion,
                    child: Text('Cancelar'),
                  ),
                   SizedBox(width: 20),
                  FloatingActionButton(
                    onPressed: guardarNombreEditado,
                    child: Text('Guardar'),
                  ),
                  SizedBox(width: 20),
              FloatingActionButton(
                onPressed: eliminarNombre,
                child: const Text('Eliminar Nombre'),
              ),
                ],
              ),               
            ],
          ),
        ),
      ),
    );
  }
}
