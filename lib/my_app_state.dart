import 'package:flutter/material.dart';
//import 'dart:math'; // Importa para usar Random

class MyAppState extends ChangeNotifier {
  var words = [
    'https://i.pinimg.com/736x/03/e2/16/03e2169f9fee506672f8f883ac4bf974.jpg',
    'https://i.pinimg.com/736x/94/49/13/944913432f64e69392cd58cc93fb5e17.jpg',
    'https://i.pinimg.com/736x/f8/a9/da/f8a9daca4075c3c78dcbd487a713217f.jpg',
    'https://i.pinimg.com/736x/02/58/b0/0258b0abf6623340dfe83d9904b1de87.jpg',
    'https://i.pinimg.com/736x/e2/2f/ea/e22fea7cd001b7494fa03e211721cb5c.jpg',
    'https://i.pinimg.com/736x/26/75/a9/2675a9906c806d2758048d475ded82c6.jpg',
    'https://i.pinimg.com/736x/20/a7/f6/20a7f6de604dbb2a552781547ba00599.jpg',
    'https://i.pinimg.com/736x/80/bf/c7/80bfc75865b5642f2d64a5a74b175de2.jpg',
    'https://i.pinimg.com/736x/39/e4/66/39e46664c41b14affc5db69b4d137027.jpg',
    'https://i.pinimg.com/736x/aa/9c/7d/aa9c7d9dab7d2ce08ebd50503b777daf.jpg',
    'https://i.pinimg.com/736x/28/e7/05/28e70539f7005822bb6c4500aeb94d24.jpg',
    'assets/perrito_local.jpg',
  ];

  var current = ''; // Almacena la palabra actual
  var favorites = <String>[]; // Lista de palabras favoritas

  MyAppState() {
    getNext(); // Inicializa con una palabra aleatoria
  }

  void getNext() {
    current = (words..shuffle()).first; // Selecciona una palabra aleatoria
    notifyListeners(); // Notifica a los oyentes sobre el cambio
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current); // Si ya es favorita, la elimina
    } else {
      favorites.add(current); // Si no es favorita, la agrega
    }
    notifyListeners(); // Notifica a los oyentes sobre el cambio
  }
}
