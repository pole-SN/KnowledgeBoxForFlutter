import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/pokemons_notifier.dart';
import '../../view_model/favorites_notifier.dart';
import '../../const/pokeapi.dart';
import 'poke_list_item.dart';
import 'poke_grid_item.dart';
import '../../model/favorite.dart';

class PokeList extends StatefulWidget {
  const PokeList({Key? key, required this.isFavoriteMode}) : super(key: key);

  final bool isFavoriteMode;

  @override
  _PokeListState createState() => _PokeListState();
}

class _PokeListState extends State<PokeList> {
  static const int pageSize = 30;
  int _currentPage = 1;
  bool _isFavoriteMode = false;
  bool isListMode = true;

  @override
  void initState() {
    super.initState();

    _isFavoriteMode = widget.isFavoriteMode;
  }

  @override
  didUpdateWidget(Widget oldWidget) {
    _isFavoriteMode = widget.isFavoriteMode;
  }

  // 表示個数
  int itemCount(int favLength, int page) {
    int ret = page * pageSize;

    if (_isFavoriteMode && ret > favLength) {
      ret = favLength;
    }
    if (ret > pokeMaxId) {
      ret = pokeMaxId;
    }
    return ret;
  }

  int itemId(List<Favorite> favs, int index) {
    int ret = index + 1;
    if (_isFavoriteMode && index < favs.length) {
      ret = favs[index].pokeId;
    }
    return ret;
  }

  bool isLastPage(int favLength, int page) {
    if (_isFavoriteMode) {
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
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            trailing: IconButton(
              padding: const EdgeInsets.all(0),
              icon: isListMode
                  ? const Icon(Icons.grid_view)
                  : const Icon(Icons.grid_view, color: Colors.blue),
              onPressed: () => {setState(() => isListMode = !isListMode)},
            ),
          ),
          Expanded(
            child: Consumer<PokemonsNotifier>(
              builder: (context, pokes, child) {
                if (itemCount(favs.favs.length, _currentPage) == 0) {
                  return const Text('no data');
                } else {
                  if (isListMode) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      itemCount: itemCount(favs.favs.length, _currentPage) + 1,
                      itemBuilder: (context, index) {
                        if (index ==
                            itemCount(favs.favs.length, _currentPage)) {
                          return OutlinedButton(
                            child: const Text('more'),
                            onPressed:
                                isLastPage(favs.favs.length, _currentPage)
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
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: itemCount(favs.favs.length, _currentPage) + 1,
                      itemBuilder: (context, index) {
                        if (index ==
                            itemCount(favs.favs.length, _currentPage)) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: OutlinedButton(
                              child: const Text('more'),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed:
                                  isLastPage(favs.favs.length, _currentPage)
                                      ? null
                                      : () => {
                                            setState(() => _currentPage++),
                                          },
                            ),
                          );
                        } else {
                          return PokeGridItem(
                            poke: pokes.byId(itemId(favs.favs, index)),
                          );
                        }
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
