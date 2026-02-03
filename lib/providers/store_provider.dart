import 'package:design_task_1/models/get_model.dart';
import 'package:design_task_1/models/otp_model.dart';
import 'package:design_task_1/models/register_step_1_model.dart';
import 'package:design_task_1/models/register_step_2_model.dart';
import 'package:design_task_1/models/response_model.dart';
import 'package:design_task_1/models/user_model.dart';
import 'package:design_task_1/repository/store_repository.dart';
import 'package:design_task_1/services/store_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Store Service
final storeServiceProvider = Provider<StoreService>((ref) {
  return StoreService();
});

//Store Repository
final storeRepositoryProvider = Provider<StoreRepository>((ref) {
  final storeService = ref.watch(storeServiceProvider);
  return StoreRepository(storeService: storeService);
});

//-------------------------------------------------------------------

//Country Code
final countryCodesProvider = FutureProvider<List<GetModel>>((ref) async {
  final repository = ref.watch(storeRepositoryProvider);
  return repository.fetchCountryCodes();
});

//Business Type
final businessTypesProvider = FutureProvider<List<GetModel>>((ref) async {
  final repository = ref.watch(storeRepositoryProvider);
  return repository.fetchBusinessTypes();
});

//Country
final countriesProvider = FutureProvider<List<GetModel>>((ref) async {
  final repository = ref.watch(storeRepositoryProvider);
  return repository.fetchCountries();
});

//State
final statesProvider = FutureProvider.family<List<GetModel>, String>((
  ref,
  value,
) async {
  final repository = ref.watch(storeRepositoryProvider);
  return repository.fetchStates(value);
});

//District
final districtsProvider = FutureProvider.family<List<GetModel>, String>((
  ref,
  value,
) async {
  final repository = ref.watch(storeRepositoryProvider);
  return repository.fetchDistricts(value);
});

//Send Otp
final sendOtpProvider = Provider.family<Future<ResponseModel>, UserModel>((
  ref,
  value,
) {
  final repo = ref.read(storeRepositoryProvider);
  return repo.sendOtp(value);
});

//Verify Otp
final verifyOtpProvider = Provider.family<Future<ResponseModel>, OtpModel>((
  ref,
  value,
) {
  final repo = ref.read(storeRepositoryProvider);
  return repo.verifyOtp(value);
});

//Register Step 1
final registerStep1Provider =
    Provider.family<Future<ResponseModel>, RegisterStep1Model>((ref, value) {
      final repo = ref.read(storeRepositoryProvider);
      return repo.registerStep1(value);
    });

//Register Step 2
class RegisterStep2Params {
  final RegisterStep2Model model;
  final int step1Id;

  RegisterStep2Params({required this.model, required this.step1Id});
}

final registerStep2Provider =
    Provider.family<Future<ResponseModel>, RegisterStep2Params>((ref, params) {
      final repo = ref.read(storeRepositoryProvider);
      return repo.registerStep2(params.model, params.step1Id);
    });
