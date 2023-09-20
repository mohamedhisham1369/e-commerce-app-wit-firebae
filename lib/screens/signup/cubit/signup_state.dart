

import 'dart:io';

abstract class SignupState {}

class SignupInitial extends SignupState {}

class signup_suffixicon_change_state extends SignupState {}
class signup_loading_state extends SignupState{}




class signup_success_state extends SignupState{


}

class signup_error_state extends SignupState{


}


class signup_createuser_success_state extends SignupState{


}

class signup_createuser_error_state extends SignupState{


}

class ImagePickedState extends SignupState {
  final File image;

  ImagePickedState(this.image);
}
class uplaadimagesuccesstofirebase extends SignupState{


}

class uplaadimagesuccesswithoutimage extends SignupState{


}