import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/pokemons_notifier.dart';
import '../../view_model/favorites_notifier.dart';
import '../../const/pokeapi.dart';
import 'poke_list_item.dart';
import '../../model/favorite.dart';

class PokeList extends StatefulWidget {
  const PokeList({Key? key}) : super(key: key);
  @override
  _PokeListState createState() => _PokeListState();
}

class _PokeListState extends State<PokeList> {
  static const int pageSize = 30;
  bool isFavoriteMode = false;
  int _currentPage = 1;

  // 表示個数
  int itemCount(int favLength, int page) {
    int ret = page * pageSize;
    if (isFavoriteMode && ret > favLength) {
      ret = favLength;
    }
    if (ret > pokeMaxId) {
      ret = pokeMaxId;
    }
    return ret;
  }

  int itemId(List<Favorite> favs, int index) {
    int ret = index + 1;
    if (isFavoriteMode && index < favs.length) {
      ret = favs[index].pokeId;
    }
    return ret;
  }

  bool isLastPage(int favLength, int page) {
    if (isFavoriteMode) {
      if (_currentPage * pageSize < favLength) {
        return false;
      }
      return true;
    } else {
      if (_currentPage * pageSize < pokeMaxId) {
        return false;
      }
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesNotifier>(
      builder: (context, favs, child) => Column(
        children: [
          Container(
            height: 24,
            alignment: Alignment.topRight,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: isFavoriteMode
                  ? const Icon(Icons.auto_awesome, color: Colors.orangeAccent)
                  : const Icon(Icons.auto_awesome_outlined),
              onPressed: () =>
                  {setState(() => isFavoriteMode = !isFavoriteMode)},
            ),
          ),
          Expanded(
            child: Consumer<PokemonsNotifier>(
              builder: (context, pokes, child) {
                if (itemCount(favs.favs.length, _currentPage) == 0) {
                  return const Text('no data');
                } else {
                  return ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    itemCount: itemCount(favs.favs.length, _currentPage) + 1,
                    itemBuilder: (context, index) {
                      if (index == itemCount(favs.favs.length, _currentPage)) {
                        return OutlinedButton(
                          child: const Text('more'),
                          onPressed: isLastPage(favs.favs.length, _currentPage)
                              ? null
                              : () => {
                                    setState(() => _currentPage++),
                                  },
                        );
                      } else {
                        return PokeListItem(
                          poke: pokes.byId(itemId(favs.favs, index)),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
