import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constats/cachehelper.dart';
import 'package:ecommerce/screens/profile/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/usermodel/usermodel.dart';


class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context)=>BlocProvider.of(context);
var uid =cachehelper.getdata(key: "uid");
  usermodel? model;

  void getdata(){
    emit(get_data_loading_state());

    FirebaseFirestore.instance.collection("users").doc(uid).get().then((value){
      model=usermodel.fromjson(value.data()!);
      print(model!.name);
      print(model!.image);

      emit(get_data_succes_state());
    }).catchError((error){
      print(error.toString());
      emit(get_data_error_state());


    });


  }




}
