import 'package:flutter/material.dart';
import 'random_words_page.dart';
import 'favorites_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pinter-Cats'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Imagen
            Image.asset('assets/logo.png', height: 280),
            SizedBox(height: 20), // Espacio entre la imagen y el texto
            // Texto
            Text(
              'Galeria bien bonita ALV',
              style: TextStyle(
                fontSize: 24,
              ), // Ajusta el estilo según sea necesario
            ),
            SizedBox(height: 20), // Espacio entre el texto y el botón
            // Botón
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RandomWordsPage()),
                );
              },
              child: Text('Ir a Palabras Aleatorias'),
            ),
          ],
        ),
      ),
    );
  }
}
