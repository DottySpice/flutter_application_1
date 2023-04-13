import 'package:flutter/material.dart';

class FlagsProvider with ChangeNotifier {
  bool _flagListPost = false;

  getFlagListPost() => this._flagListPost;
  setFlagListPost() {
    this._flagListPost = !_flagListPost;
    notifyListeners();
  }
}
