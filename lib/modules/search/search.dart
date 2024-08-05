import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/modules/search/cubit/cubit.dart';
import 'package:shoping/modules/search/cubit/state.dart';
import 'package:shoping/shared/component/component.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<FormState>();
    TextEditingController searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, AppSearchState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Search"),
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                ),
              ),
              body: Column(
                children: [
                  if (state is GetSearchDataLoadingState)
                    LinearProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: key,
                        child: defualtTextFormFiled(
                            onSubmitted: (value) {
                              SearchCubit.get(context).getSearch(value!);
                            },
                            label: "Search",
                            prefIcon: Icons.search,
                            controller: searchController,
                            function: (validate) {
                              if (validate!.isEmpty) {
                                return "can't search for nothing!";
                              }
                              return null;
                            }),
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if(state is GetSearchDataSuccessState)
                  Expanded(
                    child: ListView.separated(
                      itemCount: SearchCubit.get(context)
                          .searchModel
                          .data!
                          .data!
                          .length,
                      separatorBuilder: (context, index) => Container(
                        color: Colors.black12,
                        height: 3,
                      ),
                      itemBuilder: (context, index) {
                        return productListBuilder(
                            SearchCubit.get(context)
                                .searchModel
                                .data!
                                .data![index],
                            true,
                            context);
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
