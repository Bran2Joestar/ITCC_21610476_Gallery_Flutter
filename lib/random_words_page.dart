import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_u2/favorites_page.dart';
import 'my_app_state.dart';

class RandomWordsPage extends StatelessWidget {
  const RandomWordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    bool isFavorite = appState.favorites.contains(
      appState.current,
    ); // Verifica si la palabra actual es favorita

    return Scaffold(
      appBar: AppBar(
        title: Text('Imagenes Lindas 😍'),
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Muestra la imagen actual
            BigCard(imageUrl: appState.current),
            // Botón de like sobre la imagen
            Positioned(
              top: 10, // Ajusta la posición vertical del botón
              right: 0, // Ajusta la posición horizontal del botón
              child: ElevatedButton(
                onPressed: () {
                  appState.toggleFavorite(); // Alterna la favorita
                },
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    CircleBorder(),
                  ), // Forma circular
                ),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appState.getNext(); // Obtiene la siguiente
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  final String imageUrl; // URL o ruta de la imagen

  const BigCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      constraints: BoxConstraints(
        maxWidth: 200, // Ancho máximo específico
        maxHeight: 300,
      ),
      child: Card(
        color: Colors.cyan,
        elevation: 4, // Sombra de la tarjeta
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              // Verifica si la imagen es local o en línea
              ClipRRect(
                borderRadius: BorderRadius.circular(10), // Bordes redondeados
                child:
                    imageUrl.startsWith('http')
                        ? FadeInImage.assetNetwork(
                          placeholder:
                              'assets/loading.gif', // Ruta del placeholder
                          image: imageUrl,
                          fit:
                              BoxFit
                                  .contain, // Ajusta la imagen a su tamaño original
                          width:
                              double.infinity, // Ancho completo del contenedor
                          height: 280, // Permite que la altura sea automática
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/error.gif', // Ruta de imagen en caso de error
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: null,
                            );
                          },
                        )
                        : Image.asset(
                          imageUrl, // Muestra la imagen local
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: null,
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
