import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/shared/component/component.dart';
import 'package:shoping/shared/cubit/cubit.dart';
import 'package:shoping/shared/cubit/state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition:  cubit.favoritesModel.favoritesDataModel != null,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) {
            if (cubit.favoritesModel.favoritesDataModel!.data!.length >= 1) {
              return ListView.separated(
                itemCount:
                    cubit.favoritesModel.favoritesDataModel!.data!.length,
                separatorBuilder: (context, index) => Container(
                  color: Colors.black12,
                  height: 3,
                ),
                itemBuilder: (context, index) {
                  return productListBuilder(cubit.favoritesModel.favoritesDataModel!.data![index].product, false, context);
                },
              );
            }
            return const Center(
              child: Text(
                "There's nothing here,try add some",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
            );
          },
        );
      },
    );
  }
}
