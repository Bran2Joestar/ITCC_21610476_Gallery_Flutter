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
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          'Imágenes Lindas 😍',
          style: TextStyle(color: Colors.white),
        ),
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
      backgroundColor: Colors.purpleAccent[10],
      body: ListView.builder(
        itemCount: appState.currentImages.length,
        itemBuilder: (context, index) {
          Map<String, String> imageInfo = appState.currentImages[index];
          return BigCard(imageInfo: imageInfo);
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
  final Map<String, String> imageInfo;

  const BigCard({super.key, required this.imageInfo});

  @override
  _BigCardState createState() => _BigCardState();
}

class _BigCardState extends State<BigCard> {
  bool _isTextVisible = false; // Estado para mostrar/ocultar el texto

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    bool isFavorite = appState.favorites.contains(widget.imageInfo['url']);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.blueGrey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isTextVisible =
                    !_isTextVisible; // Alternar visibilidad del texto
              });
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:
                      widget.imageInfo['url']!.startsWith('http')
                          ? FadeInImage.assetNetwork(
                            placeholder: 'assets/loading.gif',
                            image: widget.imageInfo['url']!,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            // Altura predefinida cuando no se ven detalles
                            height: _isTextVisible ? null : 280,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/error.gif',
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: _isTextVisible ? null : 280,
                              );
                            },
                          )
                          : Image.asset(
                            widget.imageInfo['url']!,
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: _isTextVisible ? null : 280,
                          ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.lightBlueAccent,
                    ),
                    onPressed: () {
                      appState.toggleFavorite(widget.imageInfo['url']!);
                    },
                    tooltip: 'Me gusta',
                    padding: EdgeInsets.all(10),
                    splashColor: Colors.red.withOpacity(0.5),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.share, color: Colors.lightBlue),
                    onPressed: () {
                      // Lógica para compartir
                    },
                    tooltip: 'Compartir',
                    padding: EdgeInsets.all(10),
                  ),
                ),
              ],
            ),
          ),
          if (_isTextVisible) ...[
            Container(
              color: Colors.blue[100],
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.imageInfo['title']!,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.imageInfo['description']!,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.imageInfo['url']!,
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
