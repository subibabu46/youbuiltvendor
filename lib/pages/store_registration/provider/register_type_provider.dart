import 'package:flutter_riverpod/legacy.dart';

enum RegisterType { store, service, none }

final registerTypeProvider = StateProvider<RegisterType>(
  (ref) => RegisterType.none,
);

extension RegisterTypeX on RegisterType {
  String get value {
    switch (this) {
      case RegisterType.store:
        return 'store';
      case RegisterType.service:
        return 'service';
      case RegisterType.none:
        return '';
    }
  }
}
