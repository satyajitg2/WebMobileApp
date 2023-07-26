import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserModel with ChangeNotifier, DiagnosticableTreeMixin {
  late User _user;

  User get user => _user;

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('user email', user.email));
  }

  void setUser(User? auth) {
    _user = auth!;
    notifyListeners();
  }
}
