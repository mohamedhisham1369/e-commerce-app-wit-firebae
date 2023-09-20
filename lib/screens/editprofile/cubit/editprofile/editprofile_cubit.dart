
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constats/cachehelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../models/usermodel/usermodel.dart';
import 'editprofile_state.dart';

class EditprofileCubit extends Cubit<EditprofileState> {
  EditprofileCubit() : super(EditprofileInitial());

  static EditprofileCubit get(context)=>BlocProvider.of(context);
  var uid =cachehelper.getdata(key: "uid");

  usermodel? model;
  File? image;
  void getdata(){
    emit(get_data_loading_state());

    FirebaseFirestore.instance.collection("users").doc(uid).get().then((value){
      model=usermodel.fromjson(value.data()!);


      emit(get_data_succes_state());
    }).catchError((error){
      print(error.toString());
      emit(get_data_error_state());


    });


  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(ImagePickedState());
    }
  }
  String?  imageUrl;

  Future<String?> uploadImageToFirebaseStorage({required File imageFile,
    required String imageName,

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

      return   downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return e.toString();
    }
  }

Future<void> updatedata({
    required String name,
    required String phone,
}) async {
    emit(updata_loading_state());
    if (image==null){
      imageUrl =  imageUrl=model!.image;
    }
    else{
      imageUrl = await uploadImageToFirebaseStorage(imageFile: image!, imageName: name ,);
    }


    FirebaseFirestore.instance.collection("users").doc(uid).update({
      "name" : name,
      "phone" : phone,
      "image" : imageUrl

    }).then((value) {

      emit(updata_sucess_state());

    }).catchError((error){
      print(error.toString());
      emit(updata_error_state());
    });


}



}
