import 'package:design_task_1/pages/repository/store_repository.dart';
import 'package:design_task_1/services/store_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storeServiceProvider = Provider<StoreService>((ref) {
  return StoreService();
});
final storeRepositoryProvider = Provider<StoreRepository>((ref) {
  final storeService = ref.watch(storeServiceProvider);
  return StoreRepository(storeService: storeService);
});
