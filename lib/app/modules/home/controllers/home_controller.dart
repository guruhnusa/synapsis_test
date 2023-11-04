import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:synapsis_test/app/data/models/all_surveys_model.dart';
import 'package:synapsis_test/app/data/services/api_services.dart';
import 'package:synapsis_test/app/routes/app_pages.dart';

class HomeController extends GetxController {

  AllSurveyModels? allSurvey;

  Future fetchAllSurvey() async {
    var response = await ApiService.getSurvey();
    allSurvey = allSurveyModelsFromJson(response);
    return allSurvey;
  }

   formatDate(String createdAt){
    DateFormat inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'");
    DateFormat outputFormat = DateFormat("dd MMM y");
    DateTime dateTime = inputFormat.parse(createdAt);
    String formattedDate = outputFormat.format(dateTime);
    return formattedDate;
  }

  void logout (){
    Get.offAllNamed(Routes.LOGIN);
  }

}
