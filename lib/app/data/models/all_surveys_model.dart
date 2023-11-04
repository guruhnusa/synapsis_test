// To parse this JSON data, do
//
//     final allSurveyModels = allSurveyModelsFromJson(jsonString);

import 'dart:convert';

AllSurveyModels allSurveyModelsFromJson(String str) => AllSurveyModels.fromJson(json.decode(str));

String allSurveyModelsToJson(AllSurveyModels data) => json.encode(data.toJson());

class AllSurveyModels {
  int code;
  bool status;
  String message;
  int totalAllData;
  List<Data> data;

  AllSurveyModels({
    required this.code,
    required this.status,
    required this.message,
    required this.totalAllData,
    required this.data,
  });

  factory AllSurveyModels.fromJson(Map<String, dynamic> json) => AllSurveyModels(
    code: json["code"],
    status: json["status"],
    message: json["message"],
    totalAllData: json["total_all_data"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "message": message,
    "total_all_data": totalAllData,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
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
  String questionName;
  String inputType;
  String questionId;

  Question({
    required this.questionName,
    required this.inputType,
    required this.questionId,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionName: json["question_name"],
    inputType: json["input_type"],
    questionId: json["question_id"],
  );

  Map<String, dynamic> toJson() => {
    "question_name": questionName,
    "input_type": inputType,
    "question_id": questionId,
  };
}
