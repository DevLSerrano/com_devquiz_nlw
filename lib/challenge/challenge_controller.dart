import 'package:flutter/material.dart';

class ChallengeController {
  final currentePageNotifier = ValueNotifier<int>(1);
  int get currentPage => currentePageNotifier.value;
  set currentPage(int value) => currentePageNotifier.value = value;

  int qntAwnserRight = 0;
}
