import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/shared/cubit/cubit.dart';
import 'package:shoping/shared/cubit/state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            return ConditionalBuilder(
              condition: cubit.categoriesModel.dataModel != null,
              fallback: (context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              builder: (context) {
                return ListView.separated(
                    itemCount: cubit.categoriesModel.dataModel!.data.length,
                  separatorBuilder:(context,index)=>Container(color: Colors.black12,height: 2,padding: const EdgeInsets.symmetric(horizontal: 10),),
                  itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          onTap: (){},
                          child: Row(children: [
                            Image(image: NetworkImage(cubit.categoriesModel.dataModel!.data[index].image!),width: 100,height: 100,),
                            const SizedBox(width: 10,),
                            Text(cubit.categoriesModel.dataModel!.data[index].name!),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios_outlined),
                          ],),
                        ),
                      );
                  } ,
                    );
              },

            );
          });

  }
}
