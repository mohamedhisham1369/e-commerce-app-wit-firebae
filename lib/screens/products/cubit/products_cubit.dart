

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constats/cachehelper.dart';
import 'package:ecommerce/models/product%20model/productmodel.dart';
import 'package:ecommerce/screens/products/cubit/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class productcubit extends Cubit<product_screen_state> {
  productcubit() : super(product_Initial());
  static productcubit get (context)=> BlocProvider.of(context);

  productmodel? model ;
  List<productmodel> product=[];
  void getdata(){
    emit(product_loading_state());
    FirebaseFirestore.instance.collection("products").get().
    then((value) {

      value.docs.forEach((element) {

        product.add(productmodel.fromjson(element.data()));

      });

      print(product[1].price);
      emit(product_success_state());

    } ).catchError((error){
      print(error.toString());
      emit(product_error_state());

    });



  }


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
    final productData = {
      'name': name,
      'category': category,
      'price': price,
      'stockQuantity': stockQuantity,
      'description': description,
      'image': image,
      'id': id,

    };

    emit(addtocart_loading_home_state());

    FirebaseFirestore.instance
        .collection("cart")
        .doc(uid)
        .collection("cart")
        .where('id', isEqualTo: id) // Check if a product with the same name already exists
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {


        emit(addtocart_error_home_state());
      } else {
        // Product doesn't exist, add it to the cart
        FirebaseFirestore.instance
            .collection("cart")
            .doc(uid)
            .collection("cart")
            .add(productData)
            .then((value) {
          emit(addtocart_success_home_state());
        }).catchError((error) {
          print(error.toString());
          emit(addtocart_error_home_state());
        });
      }
    }).catchError((error) {
      print(error.toString());
      emit(addtocart_error_home_state());
    });
  }

}
