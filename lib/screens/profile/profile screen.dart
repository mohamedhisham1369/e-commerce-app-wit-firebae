import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/constats/cachehelper.dart';
import 'package:ecommerce/screens/editprofile/cubit/editprofile.dart';
import 'package:ecommerce/screens/profile/cubit/profile_cubit.dart';
import 'package:ecommerce/screens/profile/cubit/profile_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constats/componet.dart';
import '../login/loginscreen.dart';
import '../myorder/myorders.dart';

class profilescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>ProfileCubit()..getdata(),
      child:BlocConsumer <ProfileCubit,ProfileState> (builder: (context,state){
        var cubit=ProfileCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title:Text("profile"),
          ),
          body:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              child:
              ConditionalBuilder(
                condition: state is! get_data_loading_state,
                builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          child: Column(
                            children: [


                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage("${cubit.model?.image}"),
                                    backgroundColor: Colors.black,
                                  ),
                                  Positioned(
                                    right: 0, // Adjust the right position to your preference
                                    bottom: 0, // Adjust the bottom position to your preference
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: CircleAvatar(
                                        radius: 20,

                                        backgroundColor: Colors.black,
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                          size: 24, // Adjust the icon size to your preference
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),



                              SizedBox(height: 20,),
                              Text("${cubit.model?.name}",
                                style: TextStyle(
                                    fontSize: 20

                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      deaafulticonbutton(icon: Icons.account_circle,   Function: (){
                        naviagte(context, edit_profile());
                      }, label: 'edit profile'),
                      SizedBox(height: 20,),
                      deaafulticonbutton(icon: Icons.shopping_cart,   Function: (){
                        naviagte(context, myorder());
                      }, label: 'my orders'),
                      SizedBox(height: 20,),
                      deaafulticonbutton(icon: Icons.logout_outlined,   Function: (){
                        cachehelper.removedata(key: "uid");
                        naviagtefinsh(context, Logincsreen());


                      }, label: 'sign out'),







                    ],


                  );
                },
                fallback: (context) => Center(child: CircularProgressIndicator()),
              ),
            ),
          ),

        );

      } , listener: (context, state){


      }) ,

    );
  }
}
