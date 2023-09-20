
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constats/cachehelper.dart';
import 'package:ecommerce/screens/product%20details/cubit/productdetails_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/product model/productmodel.dart';

class ProductdetailsCubit extends Cubit<ProductdetailsState> {
  ProductdetailsCubit() : super(ProductdetailsInitial());


  static ProductdetailsCubit get (context)=> BlocProvider.of(context);







  var uid = cachehelper.getdata(key: "uid");
  productmodel? modeldata;

  void addtocart({
    required String name,
    required String category,
    required String price,
    required String stockQuantity,
    required String description,
    required String image,
    required int id,

  }) {
    productmodel modeldate = productmodel(
      stockQuantity,
      category,
      price,
      image,
      name,
      description,
      id,

    );

    emit(addtocart_loading_state());

    FirebaseFirestore.instance
        .collection("cart")
        .doc(uid)
        .collection("cart")
        .doc("${id}")
        .set( modeldate.tojson())
        .then((value) {
      emit(addtocart_success_state());
    }).catchError((error) {
      print(error.toString());
      emit(addtocart_error_state());
    });
  }



}
