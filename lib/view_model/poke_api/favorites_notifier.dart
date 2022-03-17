import 'package:flutter/material.dart';
import '../../model/poke_api/favorite.dart';
import '../../repository/poke_api/favorites_crud.dart';

class FavoritesNotifier extends ChangeNotifier {
  final List<Favorite> _favs = [];

  List<Favorite> get favs => _favs;

  FavoritesNotifier() {
    syncDb();
  }

  void toggle(Favorite fav) {
    if (isExist(fav.pokeId)) {
      delete(fav.pokeId);
    } else {
      add(fav);
    }
  }

  bool isExist(int id) {
    if (_favs.indexWhere((fav) => fav.pokeId == id) < 0) {
      return false;
    }
    return true;
  }

  void syncDb() async {
    FavoritesCURD.read().then(
      (val) => _favs
        ..clear()
        ..addAll(val),
    );
    notifyListeners();
  }

  void add(Favorite fav) async {
    await FavoritesCURD.create(fav);
    syncDb();
  }

  void delete(int id) async {
    await FavoritesCURD.delete(id);
    syncDb();
  }
}
