import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_app_state.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(title: Text('Favoritos')),
      body: ListView.builder(
        itemCount: appState.favorites.length,
        itemBuilder: (context, index) {
          String url = appState.favorites[index];
          Map<String, String>? imageInfo = appState.images.firstWhere(
            (image) => image['url'] == url,
          );

          if (imageInfo == null) {
            return SizedBox.shrink(); // No hay información, no mostramos nada
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:
                        imageInfo['url']!.startsWith('http')
                            ? FadeInImage.assetNetwork(
                              placeholder: 'assets/loading.gif',
                              image: imageInfo['url']!,
                              fit: BoxFit.cover,
                              width: 100, // Ancho fijo para la imagen
                              height: 100, // Altura fija para la imagen
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/error.gif',
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                );
                              },
                            )
                            : Image.asset(
                              imageInfo['url']!,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                  ),
                  SizedBox(width: 10), // Espaciado entre imagen y texto
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          imageInfo['title']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          imageInfo['description']!,
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      appState.toggleFavorite(
                        url,
                      ); // Alternar el estado de favorito
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
