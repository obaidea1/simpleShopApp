import 'package:shoping/models/login_moudle.dart';
import 'package:shoping/models/register_model.dart';

abstract class LoginStatus {}

class LoginInitialState extends LoginStatus {}
class ChangeAbscureTextState extends LoginStatus{}
class LoginLodingState extends LoginStatus {}
class LoginSuccessState extends LoginStatus {
   LoginModel loginModle;
   LoginSuccessState({required this.loginModle});

}
class LoginErrorState extends LoginStatus {
  final String error;

  LoginErrorState(this.error);

}
class RegisterSuccessState extends LoginStatus{
  RegisterModel registerModel;
  RegisterSuccessState({required this.registerModel});
}
class RegisterLoadingState extends LoginStatus{}
class RegisterErrorState extends LoginStatus{
  final String error;
  RegisterErrorState({required this.error});
}
