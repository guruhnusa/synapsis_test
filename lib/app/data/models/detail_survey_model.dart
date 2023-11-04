// To parse this JSON data, do
//
//     final detailSurvey = detailSurveyFromJson(jsonString);

import 'dart:convert';

DetailSurvey detailSurveyFromJson(String str) => DetailSurvey.fromJson(json.decode(str));

String detailSurveyToJson(DetailSurvey data) => json.encode(data.toJson());

class DetailSurvey {
  int code;
  bool status;
  String message;
  Data data;

  DetailSurvey({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });

  factory DetailSurvey.fromJson(Map<String, dynamic> json) => DetailSurvey(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String id;
  String surveyName;
  int status;
  int totalRespondent;
  DateTime createdAt;
  DateTime updatedAt;
  List<Question> questions;

  Data({
    required this.id,
    required this.surveyName,
    required this.status,
    required this.totalRespondent,
    required this.createdAt,
    required this.updatedAt,
    required this.questions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    surveyName: json["survey_name"],
    status: json["status"],
    totalRespondent: json["total_respondent"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "survey_name": surveyName,
    "status": status,
    "total_respondent": totalRespondent,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
  };
}

class Question {
  String id;
  int questionNumber;
  String surveyId;
  String section;
  String inputType;
  String questionName;
  String questionSubject;
  List<Option>? options;

  Question({
    required this.id,
    required this.questionNumber,
    required this.surveyId,
    required this.section,
    required this.inputType,
    required this.questionName,
    required this.questionSubject,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    questionNumber: json["question_number"],
    surveyId: json["survey_id"],
    section: json["section"],
    inputType: json["input_type"],
    questionName: json["question_name"],
    questionSubject: json["question_subject"],
    options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question_number": questionNumber,
    "survey_id": surveyId,
    "section": section,
    "input_type": inputType,
    "question_name": questionName,
    "question_subject": questionSubject,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
  };
}

class Option {
  String id;
  String questionId;
  String optionName;
  int value;
  String color;

  Option({
    required this.id,
    required this.questionId,
    required this.optionName,
    required this.value,
    required this.color,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    questionId: json["question_id"],
    optionName: json["option_name"],
    value: json["value"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question_id": questionId,
    "option_name": optionName,
    "value": value,
    "color": color,
  };
}
