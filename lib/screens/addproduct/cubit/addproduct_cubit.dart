
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/product model/productmodel.dart';
import 'addproduct_state.dart';

class AddproductCubit extends Cubit<AddproductState> {
  AddproductCubit() : super(AddproductInitialstate());



  static AddproductCubit get(context)=>BlocProvider.of(context );

var image;
  Future<void> pickImage() async {

    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image=   File(pickedFile.path);
      print(image.toString());
      emit(ImagePickedState(File(pickedFile.path)));
    }
  }

var id =4;
  Future<void> addprodcuttofirebase({
    required String name,
    required String category,
    required String price ,
    required String stockQuantity,
    required String description,

  }) async {
    emit (addproductloadingstate());
    final imageUrl = await uploadImageToFirebaseStorage(imageFile: image!, imageName: name );


    productmodel model = new productmodel(stockQuantity, category, price,imageUrl,name, description,id);

    FirebaseFirestore.instance.collection("products").doc().set(
      model.tojson(),
    ).then((value) {
      id++;
      emit(addproductsuccessstate());
    }).catchError((error){
      print(error.toString());
      emit(addproducterrorstate());
    });
  }








  Future<String?> uploadImageToFirebaseStorage({required File imageFile,
    required String imageName,

  }) async {

    try {


      final Reference storageReference = FirebaseStorage.instance.ref("products").child(imageName);

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
