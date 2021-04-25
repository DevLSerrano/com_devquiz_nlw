import 'package:devquiz/challenge/challenge_page.dart';
import 'package:devquiz/core/core.dart';
import 'package:devquiz/home/home_controller.dart';
import 'package:devquiz/home/home_state.dart';
import 'package:devquiz/home/widgets/appBar/app_bar_widget.dart';
import 'package:devquiz/home/widgets/level_buttons/level_button_widget.dart';
import 'package:devquiz/home/widgets/quiz_card/quiz_card_widget.dart';
import 'package:devquiz/shared/models/quizz_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  @override
  void initState() {
    super.initState();

    controller.getUser();
    controller.getQuizzesFacil();
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.state == HomeState.success) {
      return Scaffold(
        appBar: AppBarWidget(user: controller.user!),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LevelButtonWidget(
                    label: 'Fácil',
                    onTap: controller.getQuizzesFacil,
                  ),
                  LevelButtonWidget(
                    label: 'Médio',
                    onTap: controller.getQuizzesMedium,
                  ),
                  LevelButtonWidget(
                    label: 'Difícil',
                    onTap: controller.getQuizzesDificil,
                  ),
                  LevelButtonWidget(
                    label: 'Perito',
                    onTap: controller.getQuizzesPerito,
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              ValueListenableBuilder<List<QuizModel>>(
                valueListenable: controller.quizzes,
                builder: (context, value, child) => Expanded(
                  child: value.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.darkGreen),
                          ),
                        )
                      : GridView.count(
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          crossAxisCount: 2,
                          children: controller.quizzes.value
                              .map((quiz) => QuizCardWidget(
                                    tagForColor: quiz.level,
                                    title: quiz.title,
                                    completed:
                                        "${quiz.questionAnswered}/${quiz.questions.length}",
                                    percent: quiz.questionAnswered /
                                        quiz.questions.length,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => ChallengePage(
                                            questions: quiz.questions,
                                            titleQuizz: quiz.title,
                                          ),
                                        ),
                                      );
                                    },
                                  ))
                              .toList(),
                        ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
          ),
        ),
      );
    }
  }
}
