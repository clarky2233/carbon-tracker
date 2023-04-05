import 'package:carbon_footprint_tracker/config/routing/named_route.dart';
import 'package:carbon_footprint_tracker/models/user_info/user_info.dart';
import 'package:carbon_footprint_tracker/models/user_info/user_info_notifier.dart';
import 'package:carbon_footprint_tracker/screens/questionnaire/widgets/electricity_question.dart';
import 'package:carbon_footprint_tracker/screens/questionnaire/widgets/food_consumption_question.dart';
import 'package:carbon_footprint_tracker/screens/questionnaire/widgets/fuel_type_question.dart';
import 'package:carbon_footprint_tracker/screens/questionnaire/widgets/transport_mode_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

final userInfoProvider = NotifierProvider<UserInfoNotifier, UserInfo>(() {
  return UserInfoNotifier();
});

class QuestionnaireScreen extends ConsumerWidget {
  const QuestionnaireScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<PageViewModel> pages = [
      PageViewModel(
        title: "Baseline Questionnaire",
        body:
            "Please answer to following questions so we can get a better understanding of your carbon footprint.",
        image: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(60),
          ),
          padding: const EdgeInsets.all(24),
          child: Image.asset("assets/images/carbon-footprint.png", scale: 3),
        ),
        // bodyWidget: const IntroQuestion(),
      ),
      PageViewModel(
        title: "Transport Mode",
        bodyWidget: const TransportModeQuestion(),
      ),
      PageViewModel(
        title: "Fuel Type",
        bodyWidget: const FuelTypeQuestion(),
      ),
      PageViewModel(
        title: "Food Consumption",
        bodyWidget: const FoodConsumptionQuestion(),
      ),
      PageViewModel(
        title: "Household Electricity",
        bodyWidget: const ElectricityQuestion(),
      ),
    ];

    final userInfoNotifier = ref.watch(userInfoProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _exit(context, userInfoNotifier),
        ),
      ),
      body: IntroductionScreen(
        pages: pages,
        dotsDecorator: DotsDecorator(
          activeColor: Theme.of(context).colorScheme.primary,
        ),
        showBackButton: true,
        done: const Text("Done"),
        next: const Icon(Icons.arrow_forward),
        back: const Icon(Icons.arrow_back),
        onDone: () => _exit(context, userInfoNotifier),
      ),
    );
  }

  void _exit(BuildContext context, UserInfoNotifier userInfoNotifier) {
    userInfoNotifier.save();
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(NamedRoute.home.name);
    }
  }
}
