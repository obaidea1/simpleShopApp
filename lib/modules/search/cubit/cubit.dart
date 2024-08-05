import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoping/models/search_model.dart';
import 'package:shoping/modules/search/cubit/state.dart';
import 'package:shoping/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<AppSearchState> {
  SearchCubit() : super(InitialState());

  static SearchCubit get(BuildContext context) => BlocProvider.of(context);

   SearchModel searchModel= SearchModel();
  void getSearch(String text) async {
    emit(GetSearchDataLoadingState());
    await DioHelper.postData(url: "products/search", data: {
      "text": text,
    },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel.data!.data!.length);
      emit(GetSearchDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchDataErrorState());
    });
  }
}
