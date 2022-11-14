import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/core/features/notifications/notifications_manager.dart';
import 'package:thunderapp/shared/core/models/recipe_model.dart';
import 'package:thunderapp/shared/core/models/user.dart';
import 'package:thunderapp/shared/core/toast/app_notification_manager.dart';

import '../utils/utils.dart';

class FirestoreDatabaseManager {
  final _db = FirebaseFirestore.instance;
  static const String recipesCollectionName = 'recipes';
  static const String triviaCollectionName = 'trivia';
  static const String usersColletionName = 'users';

  final user = FirebaseAuth.instance;
  List<RecipeModel> userFavs = [];
  Future<bool> createUserInDB(String email) async {
    _db.collection(usersColletionName).add({'email': email, 'favs': [], 'ratedRecipes': []}).then((value) {
      return true;
    });
    return false;
  }

  Future<EggUser> getSpecifiedUser() async {
    List<String> recipes = [];
    EggUser? eggUser;

    try {
      await _db.collection(usersColletionName).where('email', isEqualTo: user.currentUser!.email).get().then((value) {
        for (var doc in value.docs) {
          if (doc.data()['ratedRecipes'] != null) {
            for (var i = 0; i < doc.data()['ratedRecipes'].length; i++) {
              recipes.add(doc.get('ratedRecipes')[i]['id'].toString());
            }
          }

          if (doc.get('ratedRecipes') != null || !doc.get('ratedRecipes').isEmpty) {}
          eggUser = EggUser(email: doc.data()['email'], ratedRecipes: recipes, id: doc.id);
          return eggUser;
        }
      });
      return eggUser!;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RecipeModel>> getRecipes() async {
    List<RecipeModel> recipes = [];
    await _db.collection(recipesCollectionName).get().then((result) {
      for (var doc in result.docs) {
        recipes.add(RecipeModel(doc.data()['title'], doc.data()['description'], doc.data()['timesMade'], Utils.calculateRecipeAverageScore(doc.data()['rate']), doc.data()['steps'], doc.data()['igredients'],
            doc.data()['difficulty'].runtimeType == String ? int.parse(doc.data()['difficulty']) : doc.data()['difficulty'], false, doc.id));
      }
    });
    return recipes;
  }

  Future<List<String>> getTriviaTexts() async {
    late List<String> texts = [];
    await _db.collection("trivia").get().then((event) {
      for (var doc in event.docs) {
        texts.add(doc.data()['text']);
      }
    });
    return texts;
  }

  Future saveFavoriteRecipe({required RecipeModel recipe}) async {
    try {
      final collection = _db.collection(usersColletionName).where('email', isEqualTo: user.currentUser!.email);
      collection.get().then((value) {
        for (var element in value.docs) {
          element.reference.update({
            'favs': FieldValue.arrayUnion([
              {'title': recipe.title, 'description': recipe.description, 'steps': recipe.steps, 'igredients': recipe.igredients, 'difficulty': recipe.difficulty}
            ])
          });
        }
      });
      //!!ADD A NEW USER INTO COLLECTION
      // _db.collection(usersColletionName).add({
      //   'email': user.currentUser!.email,
      //   'favs': [
      //     {
      //       'title': 'Ovo de codorna pra cumerrr',
      //       'description': 'Have you ever see the rain?'
      //     }
      //   ]
      // });
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> unfovorite(RecipeModel recipe) async {
    try {
      final collection = _db.collection(usersColletionName).where('email', isEqualTo: user.currentUser!.email);
      collection.get().then((value) {
        for (var element in value.docs) {
          element.reference.update({
            'favs': FieldValue.arrayRemove([recipe.toJson()])
          });
          log('succesfuly removed favorite');
        }
      });
      return true;
    } on FirebaseException catch (fe) {
      log('something got wrong while unfavorinting: $fe');
      return false;
    } catch (e) {
      log('something got wrong while unfavorinting: $e');
      rethrow;
    }
  }

  Future<List<RecipeModel>> getUserFavorites() async {
    try {
      _db.collection(usersColletionName).where('email', isEqualTo: user.currentUser!.email).get().then((value) {
        for (var doc in value.docs) {
          for (var i = 0; i < doc.data()['favs'].length; i++) {
            userFavs.add(
              RecipeModel(
                doc.get('favs')[i]['title'],
                doc.get('favs')[i]['description'],
                0,
                0,
                doc.get('favs')[i]['steps'],
                doc.get('favs')[i]['igredients'],
                doc.get('favs')[i]['difficulty'],
                false,
                doc.id,
              ),
            );
          }
        }
      });
      return userFavs;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RecipeModel>> performSimpleQuery(String searchQuery) async {
    String keyword = searchQuery.toLowerCase();
    List<RecipeModel> foundRecipes = [];
    final recipesRef = _db.collection(recipesCollectionName);
    final result = await recipesRef.orderBy('title').startAt([keyword]).endAt(['$keyword\uf8ff']).get();
    if (result.docs.isNotEmpty) {
      for (var doc in result.docs) {
        foundRecipes.add(RecipeModel.fromJson(data: doc));
      }
    } else {}

    return foundRecipes;
  }

  Future rateRecipe(String docId, int rating, int timesMade) async {
    _db.collection(recipesCollectionName).doc(docId).update({
      'rating': rating,
      'rate': FieldValue.arrayUnion([rating]),
      'timesMade': timesMade + 1
    }).then((value) {
      log('Successfuly rated recipe');
      saveRatedInfoInProfile(docId);
    }).catchError((error) {
      throw Exception('error: $error');
    });
  }

  Future saveRatedInfoInProfile(String docId) async {
    final collection = _db.collection(usersColletionName).where('email', isEqualTo: user.currentUser!.email);
    collection.get().then((value) {
      for (var element in value.docs) {
        element.reference.update({
          'ratedRecipes': FieldValue.arrayUnion([
            {'id': docId}
          ])
        });
      }
    });
  }

  Future deleteAccount() async {
    user.currentUser!.delete().then((value) => AppSnackbarManager.showSimpleNotification(NotificationType.success)).catchError((e) {
      log('error: $e');
      AppSnackbarManager.showSimpleNotification(NotificationType.error, 'Não conseguimos excluir sua conta');
    });
  }
}
