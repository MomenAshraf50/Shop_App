import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/home_cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';

void navigateTo(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void navigateToAndFinish(BuildContext context, Widget screen) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => screen), (route) {
    return false;
  });
}

Widget defaultTextFormField({
  required TextEditingController controller,
  required String label,
  String? Function(String?)? validator,
  required IconData prefix,
  required TextInputType inputType,
  bool isPassword = false,
  Function(String)? onChanged,
  Function(String)? onSubmitted,
  IconData? suffix,
  VoidCallback? onPressed,
  VoidCallback? onTap,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    obscureText: isPassword,
    onChanged: onChanged,
    onFieldSubmitted: onSubmitted,
    onTap: onTap,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: IconButton(
        onPressed: onPressed,
        icon: Icon(suffix),
      ),
      border: const OutlineInputBorder(),
    ),
  );
}

Widget defaultButton({required String text, required VoidCallback onPressed}) =>
    Container(
        height: 40.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: defaultColor, borderRadius: BorderRadius.circular(10.0)),
        child: MaterialButton(
          onPressed: onPressed,
          height: 30.0,
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ));

void showToast(String msg,ToastStates state){
   Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastStates{SUCCESS,ERROR,WARNING}

Color toastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}

Widget buildProductItem(product,BuildContext context,{bool isSearch = false}) => Container(
  width: double.infinity,
  height: 120,
  decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10)
  ),
  child: Row(
    children: [
      const SizedBox(width: 10,),
      Stack(
          alignment: AlignmentDirectional.bottomStart,
          children:[
            Image(
              image: NetworkImage('${product!.image}'),
              width: 100,
              height: 100,
            ),
            if(product.discount !=0&& !isSearch ) Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              color: Colors.red,
              child: const Text(
                'DISCOUNT',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10
                ),
              ),
            )
          ]
      ),
      const SizedBox(width: 10,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            Text(
              '${product.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,

            ),
            const SizedBox(width: 8,),
            const Spacer(),
            Row(
              children: [
                Text(
                  '${product.price}',
                  style: const TextStyle(
                      fontSize: 12,
                      color: defaultColor
                  ),
                ),
                const SizedBox(width: 5,),
                if(product.discount != 0&& !isSearch) Text(
                  '${product.oldPrice}',
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: (){
                    HomeCubit.get(context).updateFavorites(product.id!);
                  },
                  icon: HomeCubit.get(context).favorites[product.id]!? const Icon(Icons.favorite,color: defaultColor,):const Icon(Icons.favorite_border),
                )],
            ),
          ],
        ),
      ),
    ],
  ),
);
