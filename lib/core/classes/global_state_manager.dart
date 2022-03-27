import 'package:flutter/material.dart';

class GlobalStateManager extends ChangeNotifier {
  bool isLoading = false;

  GlobalStateManager() : super();

  void doLoad() {
    isLoading != isLoading;
    notifyListeners();
  }
}
