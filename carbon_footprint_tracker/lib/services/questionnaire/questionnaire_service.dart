import 'package:carbon_footprint_tracker/models/user_info/user_info.dart';
import 'package:carbon_footprint_tracker/services/questionnaire/questionnaire_service.objectbox.dart';

abstract class QuestionnaireService {
  QuestionnaireService._constructor();

  static final QuestionnaireService _instance =
      QuestionnaireServiceObjectBox.instance;

  static QuestionnaireService get instance => _instance;

  UserInfo getAnswers();

  void saveAnswers(UserInfo userInfo);
}
