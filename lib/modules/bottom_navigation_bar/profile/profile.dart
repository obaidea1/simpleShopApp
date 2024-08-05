import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/shared/component/component.dart';
import 'package:shoping/shared/cubit/cubit.dart';
import 'package:shoping/shared/cubit/state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = cubit.profileModle.userData!.name!;
        emailController.text = cubit.profileModle.userData!.email!;
        phoneController.text = cubit.profileModle.userData!.phone!;
        return ConditionalBuilder(
          condition:
               cubit.profileModle != null,
          builder: (context) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Profile",
                          style: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).primaryColor,
                              fontWeight: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .fontWeight),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Card(
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Name",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  defualtTextFormFiled(
                                      controller: nameController,
                                      isEnable: cubit.profileEditing,
                                      function: (value) {
                                        if(value!.isEmpty){
                                          return "can't be empty";
                                        }
                                        return null;
                                      },
                                      prefIcon: Icons.person),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  defualtTextFormFiled(
                                      controller: emailController,
                                      isEnable: cubit.profileEditing,
                                      function: (value) {
                                        if(value!.isEmpty){
                                          return "can't be empty";
                                        }
                                        return null;
                                      },
                                      prefIcon: Icons.email_outlined),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text("Phone",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  defualtTextFormFiled(
                                      controller: phoneController,
                                      isEnable: cubit.profileEditing,
                                      function: (value) {
                                        if(value!.isEmpty){
                                          return "can't be empty";
                                        }
                                        return null;
                                      },
                                      prefIcon: Icons.phone),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              onPressed: () {
                                cubit.changeProfileEditing(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                );
                              },
                              icon: Icon(
                                cubit.profileEditing
                                    ? Icons.save
                                    : Icons.edit_rounded,
                                color: Theme.of(context).primaryColor,
                              ),
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }
}
