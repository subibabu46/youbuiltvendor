import 'package:design_task_1/models/otp_model.dart';
import 'package:design_task_1/models/response_model.dart';
import 'package:design_task_1/models/user_model.dart';
import 'package:design_task_1/providers/store_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerProvider = Provider.family<Future<ResponseModel>, UserModel>((
  ref,
  value,
) {
  final repo = ref.read(storeRepositoryProvider);
  return repo.postUserInfo(value);
});
final otpProvider = Provider.family<Future<ResponseModel>, OtpModel>((
  ref,
  value,
) {
  final repo = ref.read(storeRepositoryProvider);
  return repo.verifyOtp(value);
});
