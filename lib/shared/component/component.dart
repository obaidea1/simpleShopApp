import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/home_model.dart';
import '../cubit/cubit.dart';

Widget defualtOitlinedButton ({
  required BuildContext context,
  required void Function() function,
  required String text,
})=> SizedBox(
  width: double.infinity,
  child: OutlinedButton(
    onPressed: function,
    child: Text(
      text,
      style: const TextStyle(fontSize: 18),
    ),
  ),
);

Widget defualtTextFormFiled({
  required TextEditingController controller,
  required String? Function(String?)? function,
  void Function(String?)? onSubmitted,
  String? label,
  TextInputType? type,
  IconData? prefIcon,
  bool? isAbscure,
  bool? isEnable,
}) {
  return TextFormField(
    controller: controller,
    validator: function,
    enabled:isEnable,
    obscureText: isAbscure ?? false,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      prefixIcon: Icon(prefIcon),
      label: Text(label??""),
    ),
    onFieldSubmitted: onSubmitted ,
    keyboardType: type ?? TextInputType.text,
  );
}

Future<bool?> toastMesage({
  required String? msg,
  required ToastState state,
}) {
  return Fluttertoast.showToast(
      msg: msg!,
      backgroundColor: selcetColor(state),
      gravity: ToastGravity.BOTTOM,
      fontSize: 16,
      toastLength: Toast.LENGTH_SHORT);
}

enum ToastState {
  success,
  warning,
  error,
}

Color selcetColor(ToastState toastState) {
  Color color;
  switch (toastState) {
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.warning:
      color = Colors.yellowAccent;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
  }
  return color;
}

Widget productBuilder(HomeModel modle, BuildContext context, AppCubit cubit) {
  return GridView.count(
    shrinkWrap: true,
    crossAxisCount: 2,
    childAspectRatio: 1 / 1.5,
    physics: const NeverScrollableScrollPhysics(),
    mainAxisSpacing: 1,
    crossAxisSpacing: 1,
    children: [
      ...List.generate(modle.homeData!.products.length, (index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: Alignment.bottomLeft, children: [
              Image.network(
                modle.homeData!.products[index].image!,
                fit: BoxFit.contain,
                width: double.infinity,
                height: 200.0,
              ),
              if (modle.homeData!.products[index].discount != 0)
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  padding: const EdgeInsets.all(2),
                  child: const Text(
                    "discount",
                    style: TextStyle(color: Colors.white),
                  ),
                )
            ]),
            Text(
              modle.homeData!.products[index].name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  modle.homeData!.products[index].price.toString(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (modle.homeData!.products[index].oldPrice !=
                    modle.homeData!.products[index].price)
                  Text(
                    modle.homeData!.products[index].oldPrice.toString(),
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough),
                  ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      cubit.changeProductFavourit(cubit.homeModel.homeData!.products[index].id!);
                    },
                    icon: Icon(
                      cubit.favouritProduct![cubit.homeModel.homeData!.products[index].id]!
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Theme.of(context).primaryColor,
                    ))
              ],
            ),
          ],
        );
      }),
    ],
  );
}
Widget productListBuilder( model,bool isSearch,BuildContext context){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    model!.image! ??
                        "https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg",
                  ),
                  width: 130,
                  height: 130,
                ),
                if(!isSearch && model.discount != 0)
                Container(
                  padding: const EdgeInsets.all(3),
                  color: Colors.red,
                  child: const Text(
                    "discount",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ]),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    model.name!
                        .toString(),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Text(
                      model.price
                          .toString(),
                      style: const TextStyle(
                          color: Colors.green, fontSize: 14),
                    ),
                    const SizedBox(width: 10),
                    if(!isSearch)
                    Text(
                      model.oldPrice
                          .toString() ,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context).changeProductFavourit(model
                            .id!);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}