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
  SharedPreferences? _pref;
  Future<void> init() async {
    _pref ??= await SharedPreferences.getInstance();
  }

  final Map<String, int> _sharedInts = {};
  final Map<String, bool> _sharedBools = {};

  void addInt({required String? name, required int? value}) {
    if (name != null && value != null) {
      _sharedInts.addAll({name: value});
    }
  }

  Future<int?> getInt({required String name}) async {
    if (_sharedInts.containsKey(name)) {
      return _sharedInts[name];
    } else {
      await init();
      final value = _pref?.getInt(name);
      if (value != null) {
        _sharedInts[name] = value;
      }
      return value;
    }
  }

  void addBool({required String? name, required bool? value}) {
    if (name != null && value != null) {
      _sharedBools.addAll({name: value});
    }
  }

  Future<bool?> getBool({required String name}) async {
    if (_sharedBools.containsKey(name)) {
      return _sharedBools[name];
    } else {
      await init();
      final value = _pref?.getBool(name);
      if (value != null) {
        _sharedBools[name] = value;
      }
      return value;
    }
  }
}
