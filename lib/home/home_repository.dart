import 'dart:convert';

import 'package:devquiz/shared/models/quizz_model.dart';
import 'package:devquiz/shared/models/user_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepository {
  Future<UserModel> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user')) {
      final userString = prefs.getString('user');
      final user = UserModel.fromJson(userString!);
      return user;
    } else {
      final response = await rootBundle.loadString('assets/database/user.json');
      final user = UserModel.fromJson(response);
      prefs.setString('user', response.toString());
      return user;
    }
  }

  Future<List<QuizModel>> getQuizzesFacil() async {
    final response =
        await rootBundle.loadString('assets/database/quizzes_facil.json');
    final list = json.decode(response) as List;
    final quizzes = list.map((e) => QuizModel.fromMap(e)).toList();
    return quizzes;
  }

  Future<List<QuizModel>> getQuizzesMedio() async {
    final response =
        await rootBundle.loadString('assets/database/quizzes_medio.json');
    final list = json.decode(response) as List;
    final quizzes = list.map((e) => QuizModel.fromMap(e)).toList();
    return quizzes;
  }

  Future<List<QuizModel>> getQuizzesDificil() async {
    final response =
        await rootBundle.loadString('assets/database/quizzes_dificil.json');
    final list = json.decode(response) as List;
    final quizzes = list.map((e) => QuizModel.fromMap(e)).toList();
    return quizzes;
  }

  Future<List<QuizModel>> getQuizzesPerito() async {
    final response =
        await rootBundle.loadString('assets/database/quizzes_perito.json');
    final list = json.decode(response) as List;
    final quizzes = list.map((e) => QuizModel.fromMap(e)).toList();

    return quizzes;
  }
}
