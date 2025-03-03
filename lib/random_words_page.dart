import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_u2/favorites_page.dart';
import 'my_app_state.dart';

class RandomWordsPage extends StatelessWidget {
  const RandomWordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Imágenes Lindas 😍'),
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
      backgroundColor: Colors.cyan,
      body: ListView.builder(
        itemCount: appState.currentImages.length,
        itemBuilder: (context, index) {
          String imageUrl = appState.currentImages[index];
          return BigCard(imageUrl: imageUrl);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appState.getNext(); // Obtiene nuevas imágenes
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

class BigCard extends StatefulWidget {
  final String imageUrl; // URL o ruta de la imagen

  const BigCard({super.key, required this.imageUrl});

  @override
  _BigCardState createState() => _BigCardState();
}

class _BigCardState extends State<BigCard> {
  bool _isTextVisible = false; // Estado para mostrar/ocultar el texto

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    bool isFavorite = appState.favorites.contains(
      widget.imageUrl,
    ); // Verifica si la imagen es favorita

    return Card(
      elevation: 4, // Sombra de la tarjeta
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Bordes redondeados
      ),
      color: Colors.blueGrey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alineación del texto
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isTextVisible =
                    !_isTextVisible; // Alterna la visibilidad del texto
              });
            },
            child: Stack(
              children: [
                // Verifica si la imagen es local o en línea
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:
                      widget.imageUrl.startsWith('http')
                          ? FadeInImage.assetNetwork(
                            placeholder:
                                'assets/loading.gif', // Ruta del placeholder
                            image: widget.imageUrl,
                            fit:
                                BoxFit
                                    .contain, // Ajusta la imagen para cubrir todo
                            width: double.infinity,
                            height: 280,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/error.gif', // Ruta de imagen en caso de error
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: 280,
                              );
                            },
                          )
                          : Image.asset(
                            widget.imageUrl, // Muestra la imagen local
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: 280,
                          ),
                ),
                // Botón de like superpuesto sobre la imagen
                Positioned(
                  top: 10, // Ajusta la posición vertical
                  right: 10, // Ajusta la posición horizontal
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color:
                          isFavorite
                              ? Colors.red
                              : Colors.lightBlueAccent, // Cambia el color
                    ),
                    onPressed: () {
                      appState.toggleFavorite(
                        widget.imageUrl,
                      ); // Alterna la favorita para esta imagen
                    },
                    tooltip: 'Me gusta', // Tooltip del botón
                    padding: EdgeInsets.all(
                      10,
                    ), // Espaciado alrededor del botón
                    splashColor: Colors.red.withOpacity(
                      0.5,
                    ), // Color al presionar
                  ),
                ),
                // Botón de compartir en la esquina inferior izquierda
                Positioned(
                  bottom: 10, // Ajusta la posición vertical
                  left: 10, // Ajusta la posición horizontal
                  child: IconButton(
                    icon: Icon(
                      Icons.share,
                      color: Colors.lightBlue, // Cambia el color
                    ),
                    onPressed: () {
                      // Lógica para compartir
                    },
                    tooltip: 'Compartir', // Tooltip del botón
                    padding: EdgeInsets.all(
                      10,
                    ), // Espaciado alrededor del botón
                  ),
                ),
              ],
            ),
          ),
          // Contenedor para el texto con fondo de otro color
          if (_isTextVisible // Muestra el texto solo si _isTextVisible es true
          ) ...[
            Container(
              color: Colors.blue[100], // Cambia esto al color que desees
              padding: const EdgeInsets.all(
                8.0,
              ), // Espaciado dentro del contenedor
              child: Text(
                widget.imageUrl,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ), // Estilo del texto
                textAlign: TextAlign.center, // Alineación del texto
                maxLines: 2, // Limita a 2 líneas si es necesario
                overflow:
                    TextOverflow
                        .ellipsis, // Muestra ... si el texto es demasiado largo
              ),
            ),
          ],
        ],
      ),
    );
  }
}
