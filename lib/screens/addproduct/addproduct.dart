import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constats/componet.dart';
import 'cubit/addproduct_cubit.dart';
import 'cubit/addproduct_state.dart';


class addprodcut extends StatelessWidget {
  var nameconttroller=TextEditingController();
  var category=TextEditingController();
  var price=TextEditingController();
  var stockQuantity=TextEditingController();
  var description=TextEditingController();
  var formkey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(create: (context )=>AddproductCubit(),
      child: BlocConsumer<AddproductCubit,AddproductState> (
        listener: (context,state){



        },
        builder: (context,state){

          return Scaffold(
            appBar: AppBar(title: Text("add product"),
              centerTitle: true,
              backgroundColor: Colors.blue,

            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height:20),

                Center(
                  child: GestureDetector(
                    onTap: () => AddproductCubit.get(context).pickImage(),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: AddproductCubit.get(context).image != null
                          ? FileImage(AddproductCubit.get(context).image!)
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
                                      return "please enter product name ";

                                    }
                                    return null;

                                  },
                                  label: "name",
                                  Prefixicon: Icons.person),
                            ),
                            SizedBox(height: 40,),
                            Container(
                              child: defaultformfield(
                                  controller:category ,
                                  type: TextInputType.text,
                                  validation: (value){
                                    if(value!.isEmpty)
                                    {
                                      return "please enter category";

                                    }
                                    return null;

                                  },
                                  label: "category ",
                                  Prefixicon: Icons.category),
                            ),

                            SizedBox(height: 40,),
                            Container(
                              child: defaultformfield(
                                  controller: price,
                                  label: "price",
                                  Prefixicon: Icons.monetization_on,

                                  validation: (value){
                                    if(value!.isEmpty  )
                                    {
                                      return "please enter a password";

                                    }
                                    return null;


                                  },
                                type: TextInputType.text,


                              ),
                            ),
                            SizedBox(height: 40,),
                            Container(
                              child: defaultformfield(
                                controller: stockQuantity,
                                label: "stockQuantity",
                                Prefixicon: Icons.cancel_presentation,

                                validation: (value){
                                  if(value!.isEmpty  )
                                  {
                                    return "please enter stockQuantity";

                                  }
                                  return null;


                                },
                                type: TextInputType.text,


                              ),
                            ),
                            SizedBox(height: 40,),
                            Container(
                              child: defaultformfield(
                                controller: description,
                                label: "description",
                                Prefixicon: Icons.description,

                                validation: (value){
                                  if(value!.isEmpty  )
                                  {
                                    return "please enter description";

                                  }
                                  return null;


                                },
                                type: TextInputType.text,


                              ),
                            ),
                            SizedBox(height: 40,),

                            Container(
                              child: loadingbutton(inputstate: state is!addproductloadingstate,
                                  buttonname:"addproduct",
                                  Function: (){
                                    if(formkey.currentState!.validate()){
                                      AddproductCubit.get(context).addprodcuttofirebase(
                                          name: nameconttroller.text,
                                          category: category.text,
                                          price: price.text,
                                          stockQuantity: stockQuantity.text,
                                        description: description.text,

                                      )

                                      ;

                                    }








                                  }  ),
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

