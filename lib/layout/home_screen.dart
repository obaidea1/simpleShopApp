import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/modules/search/search.dart';
import 'package:shoping/shared/component/constant.dart';
import 'package:shoping/shared/cubit/cubit.dart';
import 'package:shoping/shared/cubit/state.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Target",
              style: TextStyle(
                  fontSize:
                      Theme.of(context).textTheme.headlineLarge!.fontSize),
            ),
            actions: [

              Padding(
                  padding: const EdgeInsets.all(10),
                  child: IconButton(
                      onPressed: () {
                        if (cubit.isInProfileScreen) {
                          signOut(context);
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const SearchScreen()),
                          );
                        }
                      },
                      icon: Icon(
                        cubit.isInProfileScreen ? Icons.logout : Icons.search,
                        size: 32,
                        color: Theme.of(context).primaryColor,
                      ))),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            onTap: (index) {
              cubit.changeBottomNavigationIndex(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.line_weight_outlined), label: "Categories"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border_outlined),
                  label: "Favorite"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
        );
      },
    );
  }
}
