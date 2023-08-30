import 'package:flutter/material.dart';
import 'package:flutter_controlled_text_field/constants.dart';

class PageNotifier extends ChangeNotifier {
  String _fieldB = kInitialValue;

  String get fieldB => _fieldB;

  void updateFieldB(String value) {
    _fieldB = value;
    notifyListeners();
  }
}
