import 'package:ecommerce/constats/cachehelper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constats/componet.dart';
import '../homescreen/homescreen.dart';
import '../signup/signupscreen.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';


class Logincsreen extends StatelessWidget {
  var emailconttroler=TextEditingController();
  var passwordcontroller=TextEditingController();
  var formkey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(create: (context )=>logincubit(),
      child: BlocConsumer<logincubit,loginstates> (

        listener: (context,state){
                      if(state is Login_success_state){
                        showtoast(msg: "welcom", color: Colors.green);
                        cachehelper.savedata(key: "uid", value: logincubit.get(context).uid!).then((value) {
                          naviagtefinsh(context, homescreen());
                        });


                      }
                      else if (state is Login_error_state){
                        showtoast(msg: "Invaild username or password", color: Colors.red);


                      }


        },
        builder: (context,state){

          return Scaffold(
            appBar: AppBar(title: Text("Login"),


            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width:MediaQuery.sizeOf(context).width,
                height:MediaQuery.sizeOf(context).height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [


                    Form(
                      key:formkey ,
                      child: Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              SizedBox(height: 30,),
                              Container(
                                child: defaultformfield(
                                    controller: emailconttroler,
                                    type: TextInputType.emailAddress,
                                    validation: (value){
                                      if(value!.isEmpty)
                                      {
                                        return "please enter a valid email";

                                      }
                                      return null;

                                    },
                                    label: "email address",
                                    Prefixicon: Icons.email),
                              ),
                              SizedBox(height: 40,),

                              Container(
                                child: defaultformfield(
                                    controller: passwordcontroller,
                                    label: "password",
                                    Prefixicon: Icons.lock,
                                    type:TextInputType.visiblePassword,
                                    ispassword: logincubit.get(context).ispasswordshow,
                                    validation: (value){
                                      if(value!.isEmpty  )
                                      {
                                        return "please enter a password";

                                      }
                                      return null;


                                    },
                                    suffix: logincubit.get(context).suffixicon,
                                    suffixPressed: (){logincubit.get(context).showLoginpassword();}
                                ),
                              ),


                              SizedBox(height: 40,),



                              Container(
                                child: loadingbutton(inputstate: state is!Login_loading_state,
                                    buttonname:"Login",
                                    Function: (){
                                      if (formkey.currentState!.validate()){
                                        logincubit.get(context).loginfunction(email: emailconttroler.text,
                                            password: passwordcontroller.text);

                                      }
                                      else{
                                        print("error solution");

                                      }

                                    }  ),
                              ),

                              SizedBox(height: 40,),

                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Don’t have an account? ',
                                      style: TextStyle(
                                        color: Color(0xFF7D8FAB),
                                        fontSize: 16,

                                        fontWeight: FontWeight.w400,
                                        height: 1.38,
                                      ),
                                    ),
                                    TextButton(onPressed: (){
                                      naviagtefinsh(context, signupscreen());

                                    }, child:  Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color:  Colors.blue,
                                        fontSize: 16,
                                        // fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        height: 1.38,
                                      ),
                                    ),),




                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),

          );
        },

      ),


    );







  }
}
