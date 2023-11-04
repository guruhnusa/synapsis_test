// To parse this JSON data, do
//
//     final answerSurvey = answerSurveyFromJson(jsonString);

import 'dart:convert';

AnswerSurvey answerSurveyFromJson(String str) => AnswerSurvey.fromJson(json.decode(str));

String answerSurveyToJson(AnswerSurvey data) => json.encode(data.toJson());

class AnswerSurvey {
  String surveyId;
  List<Answer> answers;

  AnswerSurvey({
    required this.surveyId,
    required this.answers,
  });

  factory AnswerSurvey.fromJson(Map<String, dynamic> json) => AnswerSurvey(
    surveyId: json["survey_id"],
    answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "survey_id": surveyId,
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
  };
}

class Answer {
  String questionId;
  String answer;

  Answer({
    required this.questionId,
    required this.answer,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    questionId: json["question_id"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId,
    "answer": answer,
  };
}
