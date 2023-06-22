import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../navigation/named_route.dart';


class QuestionnaireTile extends StatelessWidget {
  const QuestionnaireTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.question_answer_outlined),
      title: const Text("Questionnaire"),
      subtitle: const Text("Provide baseline information"),
      onTap: () {
        context.pushNamed(NamedRoute.questionnaire.name);
      },
    );
  }
}
