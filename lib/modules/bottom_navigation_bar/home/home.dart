import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/shared/cubit/cubit.dart';
import 'package:shoping/shared/cubit/state.dart';

import '../../../shared/component/component.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: cubit.homeModel.homeData != null,
            builder: (context) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CarouselSlider(
                      items: cubit.homeModel.homeData!.banners.map((element) {
                        return Builder(builder: (context) {
                          return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image(
                                  image: NetworkImage(element.image!),
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover));
                        });
                      }).toList(),
                      options: CarouselOptions(
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlay: true,
                        viewportFraction: 1.0,
                        animateToClosest: true,
                        enlargeCenterPage: false,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayInterval: const Duration(seconds: 3),
                        reverse: false,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: productBuilder(cubit.homeModel, context, cubit),
                    ),
                  ],
                ),
              );
            },
            fallback: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
      },
    );
  }

}
