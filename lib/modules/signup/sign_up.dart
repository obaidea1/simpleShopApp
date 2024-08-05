import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layout/home_screen.dart';
import 'package:shoping/modules/login/login.dart';
import 'package:shoping/shared/network/local/cash_helper.dart';

import '../../shared/component/component.dart';
import '../../shared/component/constant.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/status.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();


    return BlocProvider(
      create: (BuildContext context) => AuthicationCubit(),
      child: BlocConsumer<AuthicationCubit, LoginStatus>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.registerModel.status!) {
              toastMesage(
                  msg: state.registerModel.message, state: ToastState.success);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const HomeLayoutScreen()),
                  (Route<dynamic> route) => false);
              token = state.registerModel.userData!.token;
              CashHelper.putData(key: 'token', value: token);
              CashHelper.putData(key: 'login', value: true);
            } else {
              toastMesage(
                  msg: state.registerModel.message, state: ToastState.warning);
            }
          }
          if (state is RegisterErrorState) {
            toastMesage(msg: state.error, state: ToastState.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/LoginBackground.png"),
                    fit: BoxFit.cover),
              ),
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                        const Text(
                          "Registration",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Register now to brows the new Collection",
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defualtTextFormFiled(
                          type: TextInputType.emailAddress,
                          prefIcon: Icons.person,
                          controller: nameController,
                          function: (value) {
                            if (value!.isEmpty) {
                              return "please put your name";
                            }
                            return null;
                          },
                          label: "Email",
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defualtTextFormFiled(
                          type: TextInputType.number,
                          prefIcon: Icons.phone_android,
                          controller: phoneController,
                          function: (value) {
                            if (value!.isEmpty) {
                              return "please put your phone Number";
                            }
                            return null;
                          },
                          label: "Phone Number",
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defualtTextFormFiled(
                          type: TextInputType.text,
                          prefIcon: Icons.email_outlined,
                          controller: emailController,
                          function: (value) {
                            if (value!.isEmpty) {
                              return "please put your email";
                            }
                            return null;
                          },
                          label: "Email",
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: passController,
                          obscureText: AuthicationCubit.get(context).isAbscure,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_open_outlined),
                            suffixIcon: IconButton(
                              onPressed: () {
                                AuthicationCubit.get(context)
                                    .changeTheAbscure();
                              },
                              icon: Icon(
                                AuthicationCubit.get(context).isAbscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            label: const Text("Password"),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please fill the password";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                AuthicationCubit.get(context).userRegistration(
                                  name: nameController.text,
                                  email: emailController.text,
                                  pass: passController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            child: const Text(
                              "Signup",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Already have account?",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const LoginScreen(),
                                            ),
                                          );
                                        },
                                      text: "Login",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
