import 'package:design_task_1/models/country_code.dart';
import 'package:design_task_1/providers/store_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countryCodesProvider = FutureProvider<List<CountryCode>>((ref) async {
  final repository = ref.watch(storeRepositoryProvider);
  return repository.fetchCountryCodes();
});
