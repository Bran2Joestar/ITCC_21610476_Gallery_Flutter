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
      body: ListView(
        children:
            appState.favorites
                .map((word) => ListTile(title: Text(word)))
                .toList(),
      ),
    );
  }
}
