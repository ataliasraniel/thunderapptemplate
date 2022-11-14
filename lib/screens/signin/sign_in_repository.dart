import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInRepository {
  Future signIn({
    required String email,
    required String password,
    required VoidCallback onSuccess,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email, password: password)
          .then((value) {
        onSuccess();
      });
    } on FirebaseAuthException catch (e) {
      log('Something got wrong while siging in: ${e.code}');
      if (e.code == 'user-not-found') {
        return Future.error(
            'Usuário não encontrado. Tem certeza que não errou nada?');
      } else if (e.code == 'wrong-password') {
        return Future.error(
            'Email ou senha incorretos, tente novamente.');
      } else {
        return Future.error('Unknown error');
      }
    } catch (e) {
      return Future.error('Houve algum erro desconhecido... :/');
    }
  }
}
