import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/constats/componet.dart';
import 'package:ecommerce/screens/editprofile/cubit/editprofile/editprofile_cubit.dart';
import 'package:ecommerce/screens/editprofile/cubit/editprofile/editprofile_state.dart';
import 'package:ecommerce/screens/homescreen/homescreen.dart';
import 'package:ecommerce/screens/profile/profile%20screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class edit_profile extends StatelessWidget {
  var name = TextEditingController();
  var phone = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => EditprofileCubit()..getdata(),
      child: BlocConsumer<EditprofileCubit, EditprofileState>(
        listener: (context, state) {
          if (state is updata_sucess_state){
            showtoast(msg: "update success", color: Colors.green);
            naviagtefinsh(context, homescreen());

          }
         else if  (state is updata_error_state){
            showtoast(msg: "server  error", color: Colors.red);

          }
        },
        builder: (context, state) {
          var cubit = EditprofileCubit.get(context);
          return Scaffold(
            appBar: AppBar(title: Text("edit profile")),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ConditionalBuilder(
                  condition: state is! get_data_loading_state,
                  builder: (context) {
                    return Form(
                      key: formkey,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: EditprofileCubit.get(context).image != null
                                    ? FileImage(EditprofileCubit.get(context).image!)
                                    : NetworkImage("${cubit.model?.image}") as ImageProvider,
                                backgroundColor: Colors.black,
                              ),
                              Positioned(
                                right: 0, // Adjust the right position to your preference
                                bottom: 0, // Adjust the bottom position to your preference
                                child: IconButton(
                                  onPressed: () => EditprofileCubit.get(context).pickImage(),
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
                          SizedBox(height: 30),
                          Column(
                            children: [
                              Container(
                                child: defaultformfield(
                                  controller: name,
                                  type: TextInputType.text,
                                  validation: (value) {
                                    if (value!.isEmpty) {
                                      return "please enter your name";
                                    }
                                    return null;
                                  },
                                  label: 'name',
                                  Prefixicon: Icons.account_circle_outlined,
                                ),
                              ),
                              SizedBox(height: 30),
                              Container(
                                child: defaultformfield(
                                  controller: phone,
                                  type: TextInputType.number,
                                  validation: (value) {
                                    if (value!.isEmpty) {
                                      return "please enter your phone number";
                                    }
                                    return null;
                                  },
                                  label: 'phone',
                                  Prefixicon: Icons.phone_android,
                                ),
                              ),
                              SizedBox(height: 30),
                              Container(
                                child: loadingbutton(
                                  inputstate: state is! updata_loading_state,
                                  buttonname: "Update",
                                  Function: () {
                                    if (formkey.currentState!.validate()) {
                                      EditprofileCubit.get(context).updatedata(name: name.text, phone: phone.text);
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  fallback: (context) => Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
