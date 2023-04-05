class NamedRoute {
  String name;
  String path;

  NamedRoute({
    required this.name,
    required this.path,
  });

  static NamedRoute home = NamedRoute(name: "home", path: "/home");

  static NamedRoute activityHistory = NamedRoute(
    name: "activity-history",
    path: "/activity-history",
  );
  static NamedRoute activity = NamedRoute(
    name: "activity",
    path: "activity/:id",
  );

  static NamedRoute settings = NamedRoute(name: "settings", path: "/settings");
  static NamedRoute trackingSettings = NamedRoute(
    name: "tracking-settings",
    path: "tracking-settings",
  );

  static NamedRoute questionnaire = NamedRoute(
    name: "questionnaire",
    path: "/questionnaire",
  );

  static NamedRoute foodInput = NamedRoute(
    name: 'food-input',
    path: "/food-input",
  );

  static NamedRoute transportInput = NamedRoute(
    name: 'transport-input',
    path: "/transport-input",
  );
}
