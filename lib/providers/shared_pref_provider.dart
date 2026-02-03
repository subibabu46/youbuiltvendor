import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((
  ref,
) async {
  return SharedPreferences.getInstance();
});

class SharedPrefCatch {
  SharedPrefCatch._();

  static final SharedPrefCatch instance = SharedPrefCatch._();

  final Map<String, int> _sharedInts = {};

  void addInt({required String? name, required int? value}) {
    if (name != null && value != null) {
      _sharedInts.addAll({name: value});
    }
  }

  int? getInt({required String name}) {
    return _sharedInts[name];
  }
}
