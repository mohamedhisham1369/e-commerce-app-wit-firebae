
import 'dart:io';

abstract class AddproductState {}

class AddproductInitialstate extends AddproductState {}

class ImagePickedState extends AddproductState {
  final File image;

  ImagePickedState(this.image);
}

class addproductloadingstate extends AddproductState {}
class addproductsuccessstate extends AddproductState {}
class addproducterrorstate extends AddproductState {}
