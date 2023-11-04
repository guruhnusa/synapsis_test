import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:synapsis_test/app/data/constraint/font_style.dart';

import '../controllers/survey_controller.dart';

class SurveyView extends GetView<SurveyController> {
  final id = Get.arguments;

  SurveyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentSurveyIndex = controller.currentSurveyIndex;
    var questionId = controller.questionId.value;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder(
          future: controller.fetchDetailSurvey(id),
          builder: (context, snapshot) {
            final survey = controller.detailSurvey;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text("Error ${snapshot.error}");
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24, right: 24, top: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 36,
                          width: 158,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border:
                                  Border.all(color: const Color(0xFF1FA0C9))),
                          child: Row(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Obx(() {
                                return Text("${controller.seconds}",
                                    style: interFont.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF1FA0C9)));
                              }),
                            ),
                            Text("Second Left",
                                style: interFont.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF1FA0C9))),
                          ]),
                        ),
                        Container(
                          height: 36,
                          width: 79,
                          decoration: BoxDecoration(
                              color: const Color(0xFF121212),
                              borderRadius: BorderRadius.circular(4)),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SimpleDialog(
                                    insetPadding: EdgeInsets.only(
                                        bottom: Get.height - 440),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 13),
                                    children: [
                                      SizedBox(
                                        width: Get.width,
                                        height: 440,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            const Text(
                                              "Survei Question",
                                              style: TextStyle(
                                                fontSize: 18.4,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF121212),
                                              ),
                                            ),
                                            const Divider(
                                              color: Color(0xFFEEF6F9),
                                              thickness: 2,
                                            ),
                                            const SizedBox(
                                              height: 17,
                                            ),
                                            SizedBox(
                                                height: 300,
                                                child: PageView.builder(
                                                  controller:
                                                      controller.pageController,
                                                  itemCount: controller
                                                      .totalPagesPopUp.value,
                                                  onPageChanged: (int index) {
                                                    controller.currentPagePopUp
                                                        .value = index;
                                                  },
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    int startIndex = index *
                                                        controller
                                                            .itemsPerPagePopUp;
                                                    int endIndex = (index + 1) *
                                                        controller
                                                            .itemsPerPagePopUp;
                                                    if (endIndex >
                                                        controller.dataPopUp) {
                                                      endIndex =
                                                          controller.dataPopUp;
                                                    }
                                                    return GridView.builder(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8),
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 5,
                                                              crossAxisSpacing:
                                                                  8,
                                                              mainAxisSpacing:
                                                                  8,
                                                              childAspectRatio:
                                                                  60 / 60),
                                                      itemCount: controller
                                                          .itemsPerPagePopUp,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int idx) {
                                                        int actualIndex =
                                                            startIndex + idx;
                                                        if (actualIndex <
                                                            controller
                                                                .dataPopUp) {
                                                          return InkWell(
                                                            onTap: () {
                                                              currentSurveyIndex
                                                                      .value =
                                                                  actualIndex;
                                                              print(
                                                                  currentSurveyIndex);
                                                            },
                                                            child: Obx(() {
                                                              return Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: currentSurveyIndex.value ==
                                                                                actualIndex
                                                                            ? Color(0xFF1FA0C9).withOpacity(
                                                                                0.2)
                                                                            : Colors
                                                                                .white,
                                                                        border: Border
                                                                            .all(
                                                                          width:
                                                                              1.5,
                                                                          color: currentSurveyIndex.value == actualIndex
                                                                              ? Color(0xFF1FA0C9)
                                                                              : Color(0xFF787878),
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                child: Text(
                                                                    "${controller.detailSurvey!.data.questions[actualIndex].questionNumber}",
                                                                    style: interFont.copyWith(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: currentSurveyIndex.value ==
                                                                                actualIndex
                                                                            ? Color(0xFF1FA0C9)
                                                                            : Color(0xFF787878))),
                                                              );
                                                            }),
                                                          );
                                                        } else {
                                                          return SizedBox();
                                                        }
                                                      },
                                                    );
                                                  },
                                                )),
                                            Obx(
                                              () => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: List.generate(
                                                  3,
                                                  (index) {
                                                    return Container(
                                                      width: 8.0,
                                                      height: 8.0,
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4.0),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: controller
                                                                    .currentPagePopUp
                                                                    .value ==
                                                                index
                                                            ? const Color(
                                                                0xFF1FA0C9)
                                                            : const Color(
                                                                0xFFD9D9D9),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    height: 25,
                                    width: 25,
                                    child:
                                        Image.asset("assets/images/list.png")),
                                Obx(() {
                                  final numberQuestion = survey!
                                      .data
                                      .questions[currentSurveyIndex.value]
                                      .questionNumber;
                                  return Text(
                                      "$numberQuestion/${survey.data.questions.length}",
                                      style: interFont.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white));
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    final numberQuestion = survey!.data
                        .questions[currentSurveyIndex.value].questionNumber;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        height: 120,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "${survey.data.surveyName}",
                                style: interFont.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF121212)),
                              ),
                              const SizedBox(
                                height: 21,
                              ),
                              Text(
                                "$numberQuestion. ${survey.data.questions[currentSurveyIndex.value].questionName}",
                                style: interFont.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF6D6D6D)),
                                textAlign: TextAlign.justify,
                              ),
                            ]),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 25,
                  ),
                  const Divider(
                    color: Color(0xFFEEF6F9),
                    thickness: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: Text(
                      "Answer",
                      style: interFont.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF121212)),
                    ),
                  ),
                  const Divider(
                    color: Color(0xFFEEF6F9),
                    thickness: 2,
                  ),
                  Obx(
                    () {
                      final questions = survey?.data.questions;
                      final currentQuestion =
                          questions![currentSurveyIndex.value];
                      questionId = currentQuestion.id;
                      if (currentQuestion.inputType == "radio_button") {
                        final options = currentQuestion.options;
                        if (options != null) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                final option = options[index];
                                return ListTile(
                                  leading: Obx(() {
                                    return Radio<String>(
                                      value: option.optionName,
                                      groupValue: controller
                                          .getAnswerForQuestion(questionId),
                                      onChanged: (value) {
                                        print(controller
                                            .getAnswerForQuestion(questionId));
                                        controller.selectOption(
                                            value!, questionId, id);
                                      },
                                    );
                                  }),
                                  title: Text(option.optionName),
                                );
                              });
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.all(24),
                        child: TextField(
                          controller: controller.location,
                          decoration: const InputDecoration(
                              hintText: "Masukan Kota/Kabupaten tempat tinggal",
                              border: OutlineInputBorder()),
                          onSubmitted: (value) {
                            controller.selectOption(value, questionId, id);
                          },
                        ),
                      );
                    },
                  ),
                  Expanded(
                      child: SizedBox(
                    height: Get.height,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 42,
                            width: 127,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Color(0XFF1FA0C9), width: 1)),
                                onPressed: () {
                                  controller.backQuestions();
                                },
                                child: Text(
                                  "Back",
                                  style: interFont.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0XFF1FA0C9)),
                                )),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                            height: 42,
                            width: 220,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1FA0C9)),
                                onPressed: () {
                                  controller.nextQuestions(
                                      survey!.data.questions.length);
                                },
                                child: Obx(() => currentSurveyIndex.value !=
                                        survey!.data.questions.length - 1
                                    ? Text("Next",
                                        style: interFont.copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white))
                                    : Text("Submit",
                                        style: interFont.copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)))),
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
