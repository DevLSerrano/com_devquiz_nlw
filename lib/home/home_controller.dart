import 'package:devquiz/home/home_repository.dart';
import 'package:devquiz/home/home_state.dart';
import 'package:devquiz/shared/models/quizz_model.dart';
import 'package:devquiz/shared/models/user_model.dart';
import 'package:flutter/material.dart';

class HomeController {
  final stateNotifier = ValueNotifier<HomeState>(HomeState.empty);
  HomeState get state => stateNotifier.value;

  final repository = HomeRepository();

  UserModel? user;
  final quizzes = ValueNotifier<List<QuizModel>>([]);

  void getUser() async {
    stateNotifier.value = HomeState.loading;

    user = await repository.getUser();
    stateNotifier.value = HomeState.success;
  }

  void getQuizzesFacil() async {
    quizzes.value = [];
    Future.delayed(Duration(seconds: 1), () async {
      quizzes.value = await repository.getQuizzesFacil();
    });
  }

  void getQuizzesMedium() async {
    quizzes.value = [];
    Future.delayed(Duration(seconds: 1), () async {
      quizzes.value = await repository.getQuizzesMedio();
    });
  }

  void getQuizzesDificil() async {
    quizzes.value = [];
    Future.delayed(Duration(seconds: 1), () async {
      quizzes.value = await repository.getQuizzesDificil();
    });
  }

  void getQuizzesPerito() async {
    quizzes.value = [];
    Future.delayed(Duration(seconds: 1), () async {
      quizzes.value = await repository.getQuizzesPerito();
    });
  }
}
