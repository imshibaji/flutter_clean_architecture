import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/services.dart';

class EnqueryProvider extends ChangeNotifier {
  List<EnqueryData>? _enqueries;

  EnqueryProvider() {
    setEnquery();
  }

  void setEnquery() {
    Future.microtask(() async {
      EnqueryService es = EnqueryService();
      Enquery? eq = await es.getAll();
      _enqueries = eq!.data!;
      notifyListeners();
    });
  }

  List<EnqueryData>? get enqueries {
    if (_enqueries != null) {
      return _enqueries!;
    }
    return null;
  }
}
