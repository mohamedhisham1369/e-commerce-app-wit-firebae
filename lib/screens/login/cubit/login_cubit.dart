import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';


class logincubit extends Cubit <loginstates>{
  logincubit():super(Login_Init_state());

  static logincubit get (context)=> BlocProvider.of(context);
  bool ispasswordshow= true;
  IconData suffixicon = Icons.visibility;
  void showLoginpassword(){
    ispasswordshow=!ispasswordshow;
    suffixicon=ispasswordshow?Icons.visibility:Icons.visibility_off;
    emit(Login_suffixicon_change_state());

  }

  void login ({required String email ,required String password } ){
    emit(Login_loading_state());


  }

  var uid ;

  void loginfunction({required var email,required var password}) {
    emit(Login_loading_state());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password).
    then((value) {
      print (value.user!.email);

       uid=value.user!.uid;

      emit(Login_success_state());
    }).
    catchError((error){
      emit(Login_error_state(error.toString()));

    });









  }



}

