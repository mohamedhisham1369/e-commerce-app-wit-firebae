

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/screens/signup/cubit/signup_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/usermodel/usermodel.dart';
import 'package:firebase_storage/firebase_storage.dart';


class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  static SignupCubit get (context)=> BlocProvider.of(context);



  bool ispasswordshow= true;
  bool ispasswordshowforconfirmpassword= true;
  IconData suffixicon = Icons.visibility;
  IconData suffixiconforconfirmpassword = Icons.visibility;

  void showpassword(){
    ispasswordshow=!ispasswordshow;
    suffixicon=ispasswordshow?Icons.visibility:Icons.visibility_off;
    emit(signup_suffixicon_change_state());

  }

  void showpasswordforconfirmpassword(){
    ispasswordshowforconfirmpassword=!ispasswordshowforconfirmpassword;
    suffixiconforconfirmpassword=ispasswordshowforconfirmpassword?Icons.visibility:Icons.visibility_off;
    emit(signup_suffixicon_change_state());

  }


  String? url;
  File? image;

  void signupfunction({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(signup_loading_state());
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(userCredential.user!.email);
      print(userCredential.user!.uid);

      final imageUrl = await uploadImageToFirebaseStorage(imageFile: image!, imageName: name ,uid:userCredential.user!.uid );

      if (imageUrl != null) {
        usercreate(
          name: name,
          phone: phone,
          email: email,
          uid: userCredential.user!.uid,
          image: imageUrl,
        );
      } else {
        emit(signup_error_state());
      }
    } catch (error) {
      print(error.toString());
      emit(signup_error_state());
    }
  }




  Future<void> pickImage() async {

    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image=   File(pickedFile.path);
      print(image.toString());
      emit(ImagePickedState(File(pickedFile.path)));
    }
  }
  void usercreate({
    required String name,
    required String phone,
    required String email,
    required String uid,
    required String image,
  }) {
    usermodel usermodle = new usermodel(name, email, phone, uid, image);

    FirebaseFirestore.instance.collection("users").doc(uid).set(
      usermodle.tojson(),
    ).then((value) {
      emit(signup_createuser_success_state());
    }).catchError((error){
      print(error.toString());
      emit(signup_createuser_error_state());
    });
  }








  Future<String?> uploadImageToFirebaseStorage({required File imageFile,
    required String imageName,
    required String uid,
  }) async {

    try {

      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User is not signed in");
      }

      final Reference storageReference = FirebaseStorage.instance.ref("usersimage").child(uid).child(imageName);

      UploadTask uploadTask = storageReference.putFile(imageFile);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      print(downloadURL);
      return   downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return e.toString();
    }
  }


}
