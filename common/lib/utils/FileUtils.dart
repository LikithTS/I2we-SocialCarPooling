
import 'package:common/network/model/QuestionarieResponse.dart';
import 'package:flutter/services.dart';

import '../network/model/QuestionarieCategory.dart';

class FileUtils {

  static Future<List<Questionarie>?> readQuestionariesData() async{
    String json =  await rootBundle.loadString('assets/json/questionarie.json');
    var questionList = questionarieResponseFromJson(json.toString());
    var categoryList = questionList.questionarie;
    return categoryList;
  }

}