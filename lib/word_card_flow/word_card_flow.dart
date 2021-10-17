import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nihongo/word_card_edit_page/word_card_edit_page.dart';
import 'package:provider/provider.dart';
import 'word_card_route_path.dart';
import '../stores/file_store.dart';
import '../word_card_list_page/word_card_data_repository.dart';
import '../word_card_list_page/word_card_list_page.dart';

class WordCardFlow extends RouterDelegate<WordCardRoutePath>
    with PopNavigatorRouterDelegateMixin<WordCardRoutePath>, ChangeNotifier {
  WordCardRoutePath _currentPath = WordCardListRoutePath();

  @override
  GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(WordCardRoutePath configuration) {
    _currentPath = configuration;
    return SynchronousFuture(null);
  }

  @override
  Widget build(BuildContext context) {
    // Must have card list page
    final List<Page<dynamic>> pages = [
      MaterialPage(
        key: const ValueKey('WordCardList'),
        child: MultiProvider(
          providers: [
            Provider(
                create: (_) => WordCardDataRepository(local: FileStore.shared))
          ],
          child: WordCardListPage(
            onAddCard: () {
              _currentPath = WordCardAddRoutePath();
              notifyListeners();
            },
          ),
        ),
      ),
    ];

    final WordCardRoutePath path = _currentPath;
    if (path is WordCardEditRoutePath) {
      pages.add(const MaterialPage(
        key: ValueKey('WordCardEdit'),
        child: WordCardEditPage(),
      ));
    }
    if (path is WordCardAddRoutePath) {
      pages.add(const MaterialPage(
        key: ValueKey('WordCardAdd'),
        child: WordCardEditPage(),
      ));
    }

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        final WordCardRoutePath path = _currentPath;

        if (path is WordCardEditRoutePath) {
          _currentPath = WordCardListRoutePath();
          notifyListeners();
          return route.didPop(result);
        } else if (path is WordCardAddRoutePath) {
          _currentPath = WordCardListRoutePath();
          notifyListeners();
          return route.didPop(result);
        }

        return false;
      },
    );
  }
}
