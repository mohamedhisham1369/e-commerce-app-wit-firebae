
import 'package:bloc/bloc.dart';
import 'package:ecommerce/screens/products/productsscreen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cart/cartscreen.dart';
import '../../profile/profile screen.dart';
import 'homescreen_state.dart';

class HomescreenCubit extends Cubit<HomescreenState> {
  HomescreenCubit() : super(HomescreenInitial());

  static HomescreenCubit get(context)=>BlocProvider.of(context);




  int currentindex=0;

  List<Widget> widgetlist=[
    productscreen(),
    cartscreen(),
    profilescreen(),
  ];

  void changebutton(int index){

    currentindex=index;
    emit (changebuttonnavbarstate());


  }

}
