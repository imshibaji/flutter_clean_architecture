import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/services.dart';

class EnqueryProvider extends ChangeNotifier {
  List<EnqueryData>? _enqueries;
  bool isLoaded = false;

  // EnqueryProvider() {
  //   setEnquery();
  // }

  void setEnquery() {
    // if (isLoaded == true) {
    //   isLoaded = false;
    //   _enqueries = null;
    //   notifyListeners();
    // }

    Future.microtask(() async {
      EnqueryService es = EnqueryService();
      Enquery? eq = await es.getAll();
      _enqueries = eq!.data!;
      isLoaded = true;
      notifyListeners();
    });
  }

  List<EnqueryData>? get enqueries {
    if (_enqueries != null && isLoaded == true) {
      return _enqueries!;
    }
    return null;
  }
}
