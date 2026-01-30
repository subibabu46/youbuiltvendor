import 'package:design_task_1/models/user_model.dart';
import 'package:design_task_1/providers/store_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerProvider = Provider.family<Future<bool>, UserModel>((ref, value) {
  final repo = ref.read(storeRepositoryProvider);
  return repo.postUserInfo(value);
});
