import 'package:finance_now/models/user_model.dart';
import 'package:finance_now/services/firebase_services.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  late UserModel userModel;

  Future<UserModel?> getUser() async {
    var user = await getUserFirebase();
    if (user == null) return null;
    userModel = UserModel(
        documentID: user.id,
        email: user.data()['correo'],
        tipeUser: user.data()['tipo_usuario']);
    notifyListeners();
    return userModel;
  }
}
