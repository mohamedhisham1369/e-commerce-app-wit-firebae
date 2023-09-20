import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constats/cachehelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ordermodel/ordermodel.dart';
import 'myorder_state.dart';



class MyorderCubit extends Cubit<MyorderState> {
  MyorderCubit() : super(MyorderInitial());

  static MyorderCubit get(context) => BlocProvider.of(context);

  List<OrderModel> orderList = [];


  var uid = cachehelper.getdata(key: "uid");

  Future<void> getOrders() async {
    emit(getdata_loading_state());
    try {
      final orderSnapshot = await FirebaseFirestore.instance.collection("order").doc(uid).get();
      final orderData = orderSnapshot.data();
      if (orderData != null) {
        final order = OrderModel.fromJson(orderData);
        orderList.add(order);
      }

      emit(getdata_success_state());

    } catch (e) {
      print(e.toString());
      emit(getdata_error_state());

    }
  }


}
