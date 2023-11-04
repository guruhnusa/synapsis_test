import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:synapsis_test/app/data/constraint/api_url.dart';

class ApiService {

  static String url = BASE_URL;

  static final headers = {
    'Content-Type': 'application/json',
    'Cookie':
    'token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsZXZlbCI6IjMiLCJleHAiOjE2OTk0NjYzODEsImlzcyI6InV5cDFmZG9iaWMifQ.JcXi7lN6MfJudWGmn9e0_y4qJHIgx6vR0ls5UI9uAxs',
  };

  static Future login(String email,String password) async {

    final rawJsonData = {
      "email": email,
      "password": password
    };
    var response = await http.post(Uri.parse(url + "login"),
        headers: headers, body: jsonEncode(rawJsonData));
    try {
      if (response.statusCode == 200) {
        print(response.body);
      } else{
        print("Error Login");
      }
    } catch (error) {
      print(error);
    }
    return response.statusCode;
  }

  static Future getSurvey() async{
    var response = await http.get(Uri.parse(url + "survey"),headers: headers);
    try{
      if(response.statusCode == 200){
        return response.body;
      }
    }catch(error){
      print(error);
    }
  }

  static Future getDetailSurvey(String id) async{
      var response = await http.get(Uri.parse(url + "survey/${id}"),headers: headers);
    try{
      if(response.statusCode == 200){
        return response.body;
      }
    }catch(error){
      print(error);
    }
  }

}
