import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final activityPermissionStatusProvider =
    FutureProvider.autoDispose<PermissionStatus>((ref) async {
  return await Permission.activityRecognition.status;
});

final locationPermissionStatusProvider =
FutureProvider.autoDispose<PermissionStatus>((ref) async {
  return await Permission.location.status;
});