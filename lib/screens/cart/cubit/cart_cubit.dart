

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constats/cachehelper.dart';
import 'package:ecommerce/screens/cart/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/product model/productmodel.dart';

class cartcubit extends Cubit<cartState> {
  cartcubit() : super(cartInitstate());

  static cartcubit get(context)=>BlocProvider.of(context);



  List<productmodel> productlist  =[];
  var uid = cachehelper.getdata(key: "uid");

 void getdata() {
    emit(getcart_loading_state());
    productlist  =[];
    FirebaseFirestore.instance.collection("cart").doc(uid).collection("cart").get().
    then((value) {

      value.docs.forEach((element) {
        productlist.add(productmodel.fromjson(element.data()));

      });

      double totalPrice=0;
      for (var item in productlist) {
        if (item.price != null) {
          totalPrice = totalPrice + double.parse(item.price!);
        }
      }

      print (totalPrice.toString());
      emit(getcart_success_state(totalPrice));

    } ).catchError((error){
      print(error.toString());
      emit(getcart_error_state());

    });



  }


  void removeitem({required productmodel model}) {
    var uid = cachehelper.getdata(key: "uid"); // Make sure uid is valid

    emit(delete_loading_state());

    FirebaseFirestore.instance
        .collection("cart")
        .doc(uid)
        .collection("cart")
        .where('id', isEqualTo: model?.id)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });

      getdata();
      emit(delete_success_state());
    }).catchError((error) {
      print("Error deleting document: $error");
      emit(delete_error_state());
    });
  }







}
