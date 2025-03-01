import 'package:flutter/material.dart'; // Importa el paquete de Flutter para crear la interfaz gráfica.
import 'package:provider/provider.dart'; // Importa el paquete Provider para gestión de estado.
import 'package:english_words/english_words.dart'; // Importa el paquete de palabras en inglés.

void main() {
  runApp(MyApp()); // Inicia la aplicación ejecutando la clase MyApp.
}

// Clase principal de la aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor de la clase.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Proveedor de estado que permite la gestión de cambios en la aplicación.
      create: (context) => MyAppState(), // Crea una instancia de MyAppState.
      child: MaterialApp(
        title: 'Proyecto Unidad 2', // Título de la aplicación.
        theme: ThemeData(
          useMaterial3: true, // Utiliza el diseño Material 3.
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.lightGreen,
          ), // Define un esquema de colores.
        ),
        home: MyHomePage(), // Establece la pantalla inicial de la aplicación.
      ),
    );
  }
}

// Clase que gestiona el estado de la aplicación
class MyAppState extends ChangeNotifier {
  var current = WordPair.random(); // Genera una palabra aleatoria.
  var favorites = <WordPair>[]; // Lista de palabras favoritas.
  //metodo para la palabra aleatoria
  void getNext() {
    current = WordPair.random(); // Obtiene una nueva palabra aleatoria.
    notifyListeners(); // Notifica a los oyentes que el estado ha cambiado.
  }

  //metodo para agregar a favorito
  void toggleFavorite() {
    // Alterna si una palabra es favorita o no.
    if (favorites.contains(current)) {
      favorites.remove(current); // Si ya es favorita, la elimina.
    } else {
      favorites.add(current); // Si no es favorita, la agrega.
    }
    notifyListeners(); // Notifica a los oyentes sobre el cambio.
  }
}

// Página principal de la aplicación
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key}); // Constructor de la clase.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla Inicial'),
        actions: [
          IconButton(
            icon: Icon(Icons.list), // Icono para ir a la lista de favoritos.
            onPressed: () {
              // Navega a la página de favoritos al presionar el icono.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navega a la página de palabras aleatorias al presionar el botón.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RandomWordsPage()),
            );
          },
          child: Text('Ir a Palabras Aleatorias'), // Texto del botón.
        ),
      ),
    );
  }
}

// Página de palabras aleatorias
class RandomWordsPage extends StatelessWidget {
  const RandomWordsPage({super.key}); // Constructor de la clase.

  @override
  Widget build(BuildContext context) {
    var appState =
        context.watch<MyAppState>(); // Observa el estado de la aplicación.
    bool isFavorite = appState.favorites.contains(
      appState.current,
    ); // Verifica si la palabra actual es favorita.

    return Scaffold(
      appBar: AppBar(
        title: Text('Generador de nombres'), // Título de la barra superior.
        actions: [
          IconButton(
            icon: Icon(Icons.list), // Icono para ir a la lista de favoritos.
            onPressed: () {
              // Navega a la página de favoritos al presionar el icono.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Idea al azar (EN INGLES):',
            style: TextStyle(fontSize: 18),
          ), // Texto de encabezado.
          SizedBox(height: 10), // Espaciado entre elementos.
          BigCard(
            word: appState.current,
          ), // Muestra la palabra actual en una tarjeta.
          SizedBox(height: 10), // Espaciado.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState
                      .toggleFavorite(); // Alterna la favorita al presionar el botón.
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                ), // Icono según si es favorita.
                label: Text('Like'), // Texto del botón.
              ),
              SizedBox(width: 10), // Espaciado.
              ElevatedButton(
                onPressed: () {
                  appState
                      .getNext(); // Obtiene la siguiente palabra al presionar el botón.
                },
                child: Text('Siguiente'), // Texto del botón.
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget para mostrar la tarjeta de palabras
class BigCard extends StatelessWidget {
  final WordPair word; // Propiedad que recibe una palabra.

  const BigCard({super.key, required this.word}); // Constructor de la clase.

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Obtiene el tema actual.
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary, // Estilo del texto.
    );

    return Card(
      color: theme.colorScheme.primary, // Color de la tarjeta.
      child: Padding(
        padding: const EdgeInsets.all(20), // Espaciado dentro de la tarjeta.
        child: Text(
          word.asLowerCase,
          style: style,
        ), // Muestra la palabra en minúsculas.
      ),
    );
  }
}

// Página para mostrar las palabras favoritas
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key}); // Constructor de la clase.

  @override
  Widget build(BuildContext context) {
    var appState =
        context.watch<MyAppState>(); // Observa el estado de la aplicación.

    return Scaffold(
      appBar: AppBar(title: Text('Favoritos')), // Título de la barra superior.
      body: ListView(
        children:
            appState.favorites
                .map(
                  (word) => ListTile(title: Text(word.asLowerCase)),
                ) // Muestra cada palabra favorita en una lista.
                .toList(),
      ),
    );
  }
}
