import 'package:devquiz/challenge/widgets/awnser/awnser_widget.dart';
import 'package:devquiz/core/core.dart';
import 'package:devquiz/shared/models/awnser_model.dart';
import 'package:devquiz/shared/models/question_model.dart';
import 'package:flutter/material.dart';

class QuizWidget extends StatefulWidget {
  const QuizWidget({Key? key, required this.question, required this.onSelected})
      : super(key: key);
  final QuestionModel question;
  final ValueChanged<bool> onSelected;

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int indexSelected = -1;

  AwnserModel awnsers(int index) => widget.question.awnsers[index];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 64,
          ),
          Text(
            widget.question.title,
            style: AppTextStyles.heading,
          ),
          SizedBox(height: 24),
          for (var i = 0; i < widget.question.awnsers.length; i++)
            AwnserWidget(
              awnserModel: awnsers(i),
              disabled: indexSelected != -1,
              onTap: (value) {
                indexSelected = i;
                setState(() {});
                Future.delayed(Duration(seconds: 1), () {
                  widget.onSelected(value);
                });
              },
              isSelected: indexSelected == i,
            ),
          // ...widget.question.awnsers
          //     .map(
          //       (e) => AwnserWidget(
          //         title: e.title,
          //         isRight: e.isRight,
          //         // isSelected: true,
          //       ),
          //     )
          //     .toList()
        ],
      ),
    );
  }
}
