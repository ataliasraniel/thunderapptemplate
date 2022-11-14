import 'dart:developer';
import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/constants/app_theme.dart';
import 'package:thunderapp/shared/core/db/firestore_db_manager.dart';
import 'package:thunderapp/shared/core/models/recipe_model.dart';
import 'package:thunderapp/shared/core/models/user.dart';
import 'package:thunderapp/shared/core/navigator.dart';
import 'package:thunderapp/shared/core/toast/app_notification_manager.dart';
import 'package:thunderapp/shared/core/user_manager.dart';

import '../../components/utils/vertical_spacer_box.dart';
import '../../shared/core/features/notifications/app_review_controller.dart';
import '../../shared/core/features/notifications/notifications_manager.dart';

class HomeScreenController with ChangeNotifier {
  final FirestoreDatabaseManager _databaseManager =
      FirestoreDatabaseManager();
  final PageController _pageController =
      PageController(initialPage: 0);
  final TextEditingController _searchTextEditingController =
      TextEditingController();
  TextEditingController get searchTextEditingController =>
      _searchTextEditingController;
  final user = FirebaseAuth.instance;
  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;
  PageController get pageController => _pageController;

  List<RecipeModel>? _todayRecipes;
  List<RecipeModel>? get todayRecipes => _todayRecipes;

  List<RecipeModel>? _topRecipes;

  List<RecipeModel>? get topRecipes => _topRecipes;

  List<RecipeModel>? _userFavorites;
  List<RecipeModel>? get userFavorites => _userFavorites;

  List<EggUser>? _eggUsers;
  List<EggUser>? get eggUsers => _eggUsers;

  int? lastTriviaIndex;
  List<String>? triviasText;
  String? triviaText;

  bool _isSearching = false;
  List<RecipeModel> _foundRecipes = [];
  List<RecipeModel> get foundRecipes => _foundRecipes;
  bool get isSearching => _isSearching;
  void initController() async {
    log('Initing controller');
    GetIt.instance<UserManager>().getCurrentUser();
    return;
    AppReviewController.rateMyApp.init().then((value) {
      if (AppReviewController.rateMyApp.shouldOpenDialog) {
        AppReviewController.rateMyApp.showRateDialog(
            navigatorKey.currentState!.context,
            message:
                'Ei, nos ajude com seu feedback. É muito importante para nós <3',
            title: 'Ei, gostando do iTea?',
            rateButton: 'Avaliar',
            laterButton: 'Hm, depois',
            noButton: 'Que tal: não',
            contentBuilder: (context, stars) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: const Text(
                'Ajude-nos com seu feedback. É muito importante para nós <3'),
          );
        });
      }
    });
  }

  void checkIfHasRated(String id) {}

  void changeAppTheme() {
    navigatorKey.currentContext!.read<AppTheme>().toggleAppTheme();
  }

  void onChangeSearchBarText(String text) {
    if (text.isNotEmpty) {
      print('is searching');
    }
  }

  void setPageIndex(int index) {
    _currentPageIndex = index;
    changePage();
    notifyListeners();
  }

  void changePage() {
    // _pageController.animateToPage(_currentPageIndex,
    //     duration: const Duration(milliseconds: 250), curve: Curves.elasticIn);
    notifyListeners();
  }

  void signOut() async {
    try {
      await user.signOut().then((value) {
        navigatorKey.currentState!
            .popUntil(ModalRoute.withName('/sign_in'));
      });
    } catch (e) {
      throw e.toString();
    }
  }

  void getRandomTriviaText() async {
    if (triviasText != null) {
      triviaText = triviasText![lastTriviaIndex!];
      int newIndex = math.Random().nextInt(triviasText!.length);
      if (lastTriviaIndex != null && newIndex == lastTriviaIndex) {
        newIndex = math.Random().nextInt(triviasText!.length);
      }
      lastTriviaIndex = newIndex;
      notifyListeners();
      return;
    } else {
      triviasText = await _databaseManager.getTriviaTexts();
      lastTriviaIndex = math.Random().nextInt(triviasText!.length);
      triviaText = triviasText![lastTriviaIndex!];
      notifyListeners();
    }
  }

  void getTodaysRecipe() async {
    try {
      _databaseManager.getRecipes().then((value) {
        _todayRecipes = value;
        setTopRecipes(value);
        notifyListeners();
      });
    } catch (e) {
      return Future.error('Algo deu errado, tente novamente :/');
    }
  }

  void setTopRecipes(List<RecipeModel> recipesData) {
    final recipes = recipesData;
    _topRecipes = [];
    recipes.sort(
      (a, b) {
        return a.timesMade.compareTo(b.timesMade);
      },
    );
    final reversedRecipes = recipes.reversed.toList();
    for (var i = 0; i < 5; i++) {
      _topRecipes!.add(reversedRecipes[i]);
    }
    notifyListeners();
  }

  void getUserFavorites() async {
    _userFavorites = null;
    notifyListeners();
    _databaseManager.getUserFavorites().then((value) {
      _userFavorites = value;
      notifyListeners();
    });
  }

  void favoriteRecipe(RecipeModel recipe) async {
    await _databaseManager.saveFavoriteRecipe(recipe: recipe);
    insertFavoriteInList(recipe);
    checkIfRecipeIsFavorite(recipe);
    AppSnackbarManager.showSimpleNotification(
        NotificationType.success);
  }

  void unfavorite(
      {int? index, RecipeModel? recipe, bool? isFromOutside}) {
    if (isFromOutside != null && isFromOutside) {
      final int indexOfFav = _userFavorites!.indexOf(recipe!);
      index = indexOfFav;
    }
    _databaseManager
        .unfovorite(_userFavorites![index!])
        .then((value) {
      if (value) {
        _userFavorites!.removeAt(index!);
        AppSnackbarManager.showSimpleNotification(
            NotificationType.success);
        notifyListeners();
      } else {
        AppSnackbarManager.showSimpleNotification(
            NotificationType.error);
      }
    });
  }

  void insertFavoriteInList(RecipeModel recipeModel) {
    _userFavorites!.add(recipeModel);
    notifyListeners();
  }

  bool checkIfRecipeIsFavorite(RecipeModel recipe) {
    for (var i = 0; i < _userFavorites!.length; i++) {
      for (var element in _userFavorites!) {
        if (element.title == recipe.title) {
          return true;
        }
      }
    }
    return false;
  }

  void searchWithQuery() async {
    _isSearching = true;
    notifyListeners();
    _foundRecipes =
        queryRecipesInLocalList(searchTextEditingController.text);
    notifyListeners();
  }

  List<RecipeModel> queryRecipesInLocalList(String query) {
    _foundRecipes.clear();
    for (var element in _todayRecipes!) {
      if (element.title.toLowerCase().contains(query) ||
          element.description.toLowerCase().contains(query)) {
        if (!_foundRecipes.contains(element)) {
          _foundRecipes.add(element);
        }
      }
    }
    return _foundRecipes;
  }

  void closeSearchBar() {
    _isSearching = false;
    _foundRecipes.clear();
    _searchTextEditingController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();
  }
}
