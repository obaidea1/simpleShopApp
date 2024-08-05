import 'package:flutter/material.dart';
import 'package:shoping/modules/login/login.dart';
import 'package:shoping/shared/network/local/cash_helper.dart';

String? token = '';

void signOut(BuildContext context) {

  CashHelper.removeData(key: 'token');
  CashHelper.removeData(key: 'login');
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()),
      (route) {
    return false;
  });

}
