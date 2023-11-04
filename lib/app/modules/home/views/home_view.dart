import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synapsis_test/app/data/constraint/font_style.dart';
import 'package:synapsis_test/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF6F9),
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Halaman Survei",
              style: interFont.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: const Color(0XFF121212)),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
                child:FutureBuilder(
                  future: controller.fetchAllSurvey(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // Menampilkan widget ini jika ada kesalahan
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return ListView.builder(
                        itemCount: controller.allSurvey!.totalAllData,
                        itemBuilder: (context, index) {
                          final surveyDataList = controller.allSurvey!.data;
                          final title = surveyDataList[index].surveyName;
                          final createdAt = surveyDataList[index].createdAt.toString();
                          final formattedDate = controller.formatDate(createdAt);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              onTap: () {
                                final id = surveyDataList[index].id;
                                Get.toNamed(Routes.SURVEY,arguments: id);
                              },
                              shape: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Color(0xFFD9D9D9)),
                              ),
                              leading: SizedBox(
                                height: 54,
                                width: 54,
                                child:
                                Image.asset("assets/images/exam.png"),
                              ),
                              title: Text(
                                "$title",
                                style: interFont.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                "Created At: $formattedDate",
                                style: interFont.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF107C41)),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
            ),
          ],
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: const Color(0xFF1FA0C9),
      onPressed: () {
        controller.logout();
    },child: const Icon(Icons.logout),),
    );
  }
}
