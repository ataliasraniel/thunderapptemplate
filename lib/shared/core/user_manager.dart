import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:thunderapp/shared/core/db/firestore_db_manager.dart';
import 'package:thunderapp/shared/core/models/user.dart';

class UserManager with ChangeNotifier {
  final FirestoreDatabaseManager _db = FirestoreDatabaseManager();
  EggUser? _eggUser;
  EggUser? get eggUser => _eggUser;
  void getCurrentUser() {
    log('Getting user');
    _db.getSpecifiedUser().then((value) {
      _eggUser = value;
      log('Fine. Got ${_eggUser!.id}');
    });
  }

  void updateRatedRecipesId(String id) {
    _eggUser!.ratedRecipes.add(id);
    notifyListeners();
  }

  bool checkIfUserHasRatedRecipe(String id) {
    if (_eggUser!.ratedRecipes.contains(id)) {
      return true;
    } else {
      return false;
    }
  }
}
