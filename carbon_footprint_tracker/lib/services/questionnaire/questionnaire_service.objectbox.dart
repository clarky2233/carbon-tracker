import 'package:carbon_footprint_tracker/models/user_info/user_info.dart';
import 'package:carbon_footprint_tracker/services/questionnaire/questionnaire_service.dart';

import '../../objectbox.g.dart';

class QuestionnaireServiceObjectBox implements QuestionnaireService {
  final Store store;

  const QuestionnaireServiceObjectBox({
    required this.store,
  });

  @override
  void saveAnswers(UserInfo userInfo) {
    final box = store.box<UserInfo>();
    box.put(userInfo, mode: userInfo.id == 0 ? PutMode.insert : PutMode.update);
  }

  @override
  UserInfo getAnswers() {
    final box = store.box<UserInfo>();
    final userInfoList = box.getAll();
    return userInfoList.isEmpty ? UserInfo() : userInfoList.first;
  }
}
