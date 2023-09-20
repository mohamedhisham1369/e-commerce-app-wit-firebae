
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constats/componet.dart';
import '../login/loginscreen.dart';
import 'cubit/signup_cubit.dart';
import 'cubit/signup_state.dart';


class signupscreen extends StatelessWidget {
  var nameconttroller=TextEditingController();
  var emailconttroler=TextEditingController();
  var passwordcontroller=TextEditingController();
  var phone=TextEditingController();
  var formkey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(create: (context )=>SignupCubit(),
      child: BlocConsumer<SignupCubit,SignupState> (
        listener: (context,state){
          if(state is signup_createuser_success_state){
            showtoast(msg: "registeriton success", color: Colors.green);
            naviagtefinsh(context, Logincsreen());
          }


        },
        builder: (context,state){

          return Scaffold(
            appBar: AppBar(title: Text("signup"),


            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height:20),

                Center(
                  child: GestureDetector(
                    onTap: () => SignupCubit.get(context).pickImage(),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: SignupCubit.get(context).image != null
                          ? FileImage(SignupCubit.get(context).image!)
                          : NetworkImage("https://i.stack.imgur.com/l60Hf.png") as ImageProvider,

                    ),
                  ),
                ),


                SizedBox(height:20),


                Form(
                  key:formkey ,
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            SizedBox(height: 30,),
                            Container(
                              child: defaultformfield(
                                  controller: nameconttroller,
                                  type: TextInputType.text,
                                  validation: (value){
                                    if(value!.isEmpty)
                                    {
                                      return "please enter  email";

                                    }
                                    return null;

                                  },
                                  label: "name",
                                  Prefixicon: Icons.person),
                            ),
                            SizedBox(height: 40,),
                            Container(
                              child: defaultformfield(
                                  controller:phone ,
                                  type: TextInputType.number,
                                  validation: (value){
                                    if(value!.isEmpty)
                                    {
                                      return "please enter  your phone number";

                                    }
                                    return null;

                                  },
                                  label: "phone ",
                                  Prefixicon: Icons.phone),
                            ),
                            SizedBox(height: 40,),
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
                                  ispassword: SignupCubit.get(context).ispasswordshow,
                                  validation: (value){
                                    if(value!.isEmpty  )
                                    {
                                      return "please enter a password";

                                    }
                                    return null;


                                  },
                                  suffix: SignupCubit.get(context).suffixicon,
                                  suffixPressed: (){SignupCubit.get(context).showpassword();}
                              ),
                            ),

                            SizedBox(height: 40,),

                            Container(
                              child: loadingbutton(inputstate: state is!signup_loading_state,
                                  buttonname:"Signup",
                                  Function: (){
                                if(formkey.currentState!.validate()){
                                  if(SignupCubit.get(context).image!=null){
                                    if(passwordcontroller.text.length>=6){
                                      SignupCubit.get(context).signupfunction(
                                        name: nameconttroller.text, phone: phone.text,
                                        email: emailconttroler.text,
                                        password: passwordcontroller.text,




                                      );
                                    }
                                    else{

                                      showtoast(msg: "password is to short", color: Colors.red);


                                    }


                                  }
                                  else{
                                    showtoast(msg: "please select profile image", color: Colors.red);

                                  }


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
                                    'I have account have an account? ',
                                    style: TextStyle(
                                      color: Color(0xFF7D8FAB),
                                      fontSize: 16,

                                      fontWeight: FontWeight.w400,
                                      height: 1.38,
                                    ),
                                  ),
                                  TextButton(onPressed: (){
                                    naviagtefinsh(context, Logincsreen());
                                  }, child:  Text(
                                    'Login ',
                                    style: TextStyle(
                                      color: Colors.blue,
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
                ),

              ],
            ),

          );
        },

      ),


    );







  }
}

