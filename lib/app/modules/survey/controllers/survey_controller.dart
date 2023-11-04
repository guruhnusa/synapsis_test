import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synapsis_test/app/data/models/answer_survey.dart';
import 'package:synapsis_test/app/data/models/detail_survey_model.dart';
import 'package:synapsis_test/app/data/services/api_services.dart';
import 'package:synapsis_test/app/routes/app_pages.dart';

class SurveyController extends GetxController {


  var currentSurveyIndex = 0.obs;

  DetailSurvey? detailSurvey;

  Future fetchDetailSurvey(String id) async {
    var response = await ApiService.getDetailSurvey(id);
    print(response);
    detailSurvey = detailSurveyFromJson(response);
    getPopUp();
    return detailSurvey;
  }

  late final TextEditingController location = TextEditingController();

  var questionId = "".obs;
  var isAnswer = false.obs;

  RxList<Answer> answers = <Answer>[].obs;

  void selectOption(String option, String questionId, String surveyId) {
    bool answerExists = false;

    // Loop untuk periksa  jawaban untuk pertanyaan tersebut sudah ada
    for (final answer in answers) {
      if (answer.questionId == questionId) {
        //untuk perbarui jawaban
        answer.answer = option;
        answerExists = true;
        break;
      }
    }
    // Jika jawaban tidak ada, tambahkan jawaban baru ke dalam list answers
    if (!answerExists) {
      Answer newAnswer = Answer(questionId: questionId, answer: option);
      answers.add(newAnswer);
    }

    // digunakan untuk memberitahu objek answers bahwa terdapat perubahan di dalamnya.
    answers.value = List.from(answers);

    final answerSurvey = AnswerSurvey(surveyId: surveyId, answers: answers);
    print(answerSurveyToJson(answerSurvey));

  }

  String getAnswerForQuestion(String questionId) {
    final selectedAnswer =  answers.firstWhere(
            (answer) => answer.questionId == questionId,
        orElse: () => Answer(questionId: questionId, answer: ''));
    return selectedAnswer.answer;
  }


  RxInt seconds = 45.obs;
  late Timer? timer;

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds --;
      } else {
        Get.offAllNamed(Routes.HOME);
        timer.cancel();
      }
    });
  }

  backQuestions() {
    if (currentSurveyIndex.value == 0) {
      Get.back();
    } else {
      currentSurveyIndex--;
    }
  }

  nextQuestions(int questionsLength )  {
    if(currentSurveyIndex.value ==  questionsLength - 1 ){
      Get.offAllNamed(Routes.HOME);
    }
    else{
      currentSurveyIndex++;
    }
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void dispose() {
    answers.clear();
    super.dispose();
  }

  @override
  void onClose() {
    timer!.cancel();
    super.onClose();
  }


  //Question PopUp
  var currentPagePopUp = 0.obs;
  var itemsPerPagePopUp = 20;
  var totalPagesPopUp = 0.obs;
  late int dataPopUp = 0;
  var pageController = PageController();

  void getPopUp() {
    if (detailSurvey != null) {
      dataPopUp = detailSurvey!.data.questions.length;
      calculateTotalPages();
      update();
    }
  }

  void calculateTotalPages() {
    totalPagesPopUp.value = (dataPopUp / itemsPerPagePopUp).ceil();
  }
}
