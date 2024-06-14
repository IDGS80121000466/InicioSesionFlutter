import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'VistaNombre.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Inicio de Sesión'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controladorNombre = TextEditingController();
  @override
  void initState() {
    super.initState();
    verificarNombreGuardado();
  }

  Future<void> verificarNombreGuardado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nombre = prefs.getString('nombre');
    if (nombre != null) {
      mostrarVistaNombre(nombre);
    }
  }

  void mostrarVistaNombre(String nombre) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => VistaNombre(nombre: nombre)),
    );
  }

  void guardarNombre() async {
  if (controladorNombre.text.isNotEmpty) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombre', controladorNombre.text);
    mostrarVistaNombre(controladorNombre.text);
  } else {
    final snackBar = SnackBar(
      content: Text('Ingresa un nombre'),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

  void limpiarNombre() {
    controladorNombre.clear();
  }
 
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
                  helperText: "Escribe tu nombre", // Pone texto abajo de la caja
                  border: OutlineInputBorder(), // pone borde al texto
                  hintText: "Escribe aqui tu nombre", //Pone texto dentro de la caja de texto
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
                  OutlinedButton(
                    onPressed: limpiarNombre,
                    child: Text('Cancelar'),
                  ),
                  const SizedBox(width: 20),
                  OutlinedButton(
                    onPressed: guardarNombre,
                    child: Text('Guardar'),
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