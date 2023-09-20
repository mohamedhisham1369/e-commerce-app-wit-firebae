// import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecommerce/constats/cachehelper.dart';
// import 'package:ecommerce/models/product%20model/productmodel.dart';
// import 'package:ecommerce/models/usermodel/usermodel.dart';
// import 'package:ecommerce/screens/payment%20method/cubit/payment_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../models/product model/productmodel.dart';
//
//
// class PaymentCubit extends Cubit<PaymentState> {
//   PaymentCubit() : super(PaymentInitial());
//   static PaymentCubit get(context)=>BlocProvider.of(context);
//   var uid = cachehelper.getdata(key: "uid");
//
//   usermodel ?model;
//
//   List<productmodel> productlist  =[];
//
//   void getdata() {
//
//     productlist  =[];
//     FirebaseFirestore.instance.collection("cart").doc(uid).collection("cart").get().
//     then((value) {
//
//       value.docs.forEach((element) {
//         productlist.add(productmodel.fromjson(element.data()));
//
//       });
//
//       double totalPrice=0;
//       for (var item in productlist) {
//         if (item.price != null) {
//           totalPrice = totalPrice + double.parse(item.price!);
//         }
//       }
//
//       print (totalPrice.toString());
//
//     } ).catchError((error){
//       print(error.toString());
//
//     });
//
//
//
//   }
//
//   void order({
//     required String cardnumber,
//     required String cvv,
//     required String address,
//     required String expiredata,
//
//
//
//   }){
//     emit(orderloadingstate());
//     getdata();
//     FirebaseFirestore.instance.collection("users").doc(uid).get().then((value) {
//       model = usermodel.fromjson(value.data()!);
//     }).catchError((e){
//       print(e.toString());
//     });
//     FirebaseFirestore.instance.collection("order").doc(uid).set({
//       "cardnumber":cardnumber,
//       "cvv":cvv,
//       "address":address,
//       "expiredata":expiredata,
//       "productlist":productlist,
//       "userlist":model?.tojson(),
//
//
//
//     }).then((value) {
//       emit(ordersucessstate());
//
//     }).catchError((e){
//
//       print(e.toString());
//       emit(ordererrorstate());
//
//     });
//
//
//
//   }
//
//
//
// }

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constats/cachehelper.dart';
import 'package:ecommerce/models/product%20model/productmodel.dart';
import 'package:ecommerce/models/usermodel/usermodel.dart';
import 'package:ecommerce/screens/payment%20method/cubit/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  static PaymentCubit get(context) => BlocProvider.of(context);
  var uid = cachehelper.getdata(key: "uid");

  usermodel? model;

  List<productmodel> productlist = [];

  Future<void> getdata() async {
    productlist = [];
    try {
      final cartSnapshot =
      await FirebaseFirestore.instance.collection("cart").doc(uid).collection("cart").get();

      cartSnapshot.docs.forEach((element) {
        productlist.add(productmodel.fromjson(element.data()));
      });

      double totalPrice = 0;
      for (var item in productlist) {
        if (item.price != null) {
          totalPrice += double.parse(item.price!);
        }
      }

      print(totalPrice.toString());
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> order({
    required String cardnumber,
    required String cvv,
    required String address,
    required String expiredata,
  }) async {
    emit(orderloadingstate());

    await getdata(); // Wait for cart data to be fetched

    try {
      final userSnapshot = await FirebaseFirestore.instance.collection("users").doc(uid).get();
      model = usermodel.fromjson(userSnapshot.data()!);
    } catch (e) {
      print(e.toString());
    }

    try {
      await FirebaseFirestore.instance.collection("order").doc(uid).set({
        "cardnumber": cardnumber,
        "cvv": cvv,
        "address": address,
        "expiredata": expiredata,
        "productlist": productlist.map((product) => product.tojson()).toList(),
        "userlist": model?.tojson(),
      });

      emit(ordersucessstate());
    } catch (e) {
      print(e.toString());
      emit(ordererrorstate());
    }
  }
}
