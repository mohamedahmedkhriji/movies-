import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/model.dart';

final List<Movie> initialData = List.generate(
    50,
    (index) => Movie(
        title: "Movie $index",
        runtime: "${Random().nextInt(100) + 60}")); //RANDOM MINITES

class MovieProvider with ChangeNotifier {
  final List<Movie> _movies = initialData;

  List<Movie> get movies => _movies; //IJIBLI LISTA FILM KOL

  final List<Movie> _myList = [];
  List<Movie> get myList => _myList; //ajouter ll list ffav

  void addToList(Movie movie) {
    // fnctadd to list
    _myList.add(movie);
    notifyListeners();
  }

  void removeFromList(Movie movie) {
    // fnctadd to list
    _myList.remove(movie);
    notifyListeners();
  }
}
