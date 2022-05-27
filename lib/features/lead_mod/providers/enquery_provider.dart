import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/services.dart';

class EnqueryProvider extends ChangeNotifier {
  List<EnqueryData>? _enqueries;
  EnqueryData? _enquery;
  bool isLoaded = false;

  void setEnquery() {
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

  void findEnqeryData(int id) {
    Future.microtask(() async {
      isLoaded = false;
      EnqueryService es = EnqueryService();
      EnquerySingle? eq = await es.getOne(id);
      _enquery = eq!.data!;
      isLoaded = true;
      notifyListeners();
    });
  }

  EnqueryData? get enquery {
    if (_enquery != null) {
      return _enquery!;
    }
    return null;
  }

  Future<EnqueryData>? getEnqeryData(int id) async {
    isLoaded = false;
    EnqueryService es = EnqueryService();
    EnquerySingle? eq = await es.getOne(id);
    _enquery = eq!.data!;
    isLoaded = true;
    notifyListeners();
    return _enquery!;
  }
}
