import 'package:carbon_footprint_tracker/models/user_info/user_info.dart';
import 'package:carbon_footprint_tracker/services/questionnaire/questionnaire_service.objectbox.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final questionnaireServiceProvider = Provider<QuestionnaireService>((ref) {
  return QuestionnaireServiceObjectBox();
});

abstract class QuestionnaireService {
  UserInfo getAnswers();

  void saveAnswers(UserInfo userInfo);
}
