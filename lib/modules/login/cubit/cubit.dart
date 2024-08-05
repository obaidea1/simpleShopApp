import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/models/login_moudle.dart';
import 'package:shoping/models/register_model.dart';
import 'package:shoping/modules/login/cubit/status.dart';
import 'package:shoping/shared/component/constant.dart';
import 'package:shoping/shared/network/remote/dio_helper.dart';

class AuthicationCubit extends Cubit<LoginStatus> {
  AuthicationCubit() : super(LoginInitialState());

  static AuthicationCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModle;

  void userLogin({
    required String email,
    required String pass,
  }) {
    emit(LoginLodingState());
    DioHelper.postData(url: 'login', data: {
      'email': email,
      'password': pass,
    }).then((value) {
      loginModle = LoginModel.fromJson(value.data);
      token = loginModle.userData!.token;

      emit(LoginSuccessState(loginModle: loginModle));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error));
    });
  }

  bool isAbscure = true;

  void changeTheAbscure() {
    isAbscure = !isAbscure;
    emit(ChangeAbscureTextState());
  }

  late RegisterModel registerModel;
  void userRegistration({
    required String name,
    required String email,
    required String pass,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: "register",
      data: {
        "name": name,
        "phone": phone,
        "email": email,
        "password": email,
        "image":"https://student.valuxapps.com/storage/uploads/users/vKUwXVRJhi_1722700219.jpeg",
      },
    ).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel: registerModel));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error: error.toString()));
    });
  }
}
