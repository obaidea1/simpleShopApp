import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/layout/home_screen.dart';
import 'package:shoping/modules/signup/sign_up.dart';
import 'package:shoping/shared/component/component.dart';
import 'package:shoping/shared/component/constant.dart';
import 'package:shoping/shared/network/local/cash_helper.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/status.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => AuthicationCubit(),
      child: BlocConsumer<AuthicationCubit, LoginStatus>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModle.status!) {
              toastMesage(msg: state.loginModle.msg, state: ToastState.success);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeLayoutScreen()),
                (route) => false,
              );
              token = state.loginModle.userData?.token ;
              CashHelper.putData(key: 'token', value: token);
              CashHelper.putData(key: 'login', value: true);
            } else {
              toastMesage(msg: state.loginModle.msg, state: ToastState.warning);
            }
          }
          if(state is LoginErrorState) {
            toastMesage(
                msg: "there's something wrong", state: ToastState.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/LoginBackground.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 4,
                          ),
                          const Text(
                            "Login",
                            style: TextStyle(fontSize: 35),
                          ),
                          const Text(
                            "Login now to browse the new Collection",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          defualtTextFormFiled(
                            type: TextInputType.emailAddress,
                            prefIcon: Icons.email_outlined,
                            controller: emailController,
                            function: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your email";
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
                                  AuthicationCubit.get(context).changeTheAbscure();
                                },
                                icon: Icon(AuthicationCubit.get(context).isAbscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,color: Theme.of(context).primaryColor,),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              label: const Text("Password"),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your password";
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
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  AuthicationCubit.get(context).userLogin(
                                    email: emailController.text,
                                    pass: passController.text,
                                  );
                                }
                              },
                              child: const Text(
                                "Login",
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
                                        text: "Don't have an account? ",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        const SignUpScreen(),
                                              ),
                                            );
                                          },
                                        text: "Register",
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
            ),
          );
        },
      ),
    );
  }
}
