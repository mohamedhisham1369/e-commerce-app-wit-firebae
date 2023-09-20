import 'package:ecommerce/constats/componet.dart';
import 'package:ecommerce/screens/payment%20method/cubit/payment_cubit.dart';
import 'package:ecommerce/screens/payment%20method/cubit/payment_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class payment extends StatelessWidget {
  var cardnumber = TextEditingController();
  var expiredate = TextEditingController();
  var cvv = TextEditingController();
  var address = TextEditingController();
  var formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PaymentCubit(),
      child: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  "payment method"
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Container(
                          child: Image(
                            image: AssetImage("assests/images/credit card.jpg"),
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: defaultformfield(
                              controller: cardnumber,
                              type: TextInputType.number,
                              validation: (value) {
                                if (value!.isEmpty) {
                                  return "cardnumber  ";
                                }
                                return null;
                              },
                              Prefixicon: Icons.payment_outlined,
                              label: "cardnumber"),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: defaultformfield(
                              controller: expiredate,
                              type: TextInputType.datetime,
                              validation: (value) {
                                if (value!.isEmpty) {
                                  return "expiredate  ";
                                }
                                return null;
                              },
                              Prefixicon: Icons.calendar_month,

                              label: "Expire date"),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: defaultformfield(
                              controller: cvv,
                              type: TextInputType.number,
                              validation: (value) {
                                if (value!.isEmpty) {
                                  return "cvv value  ";
                                }
                                return null;
                              },

                              suffix: Icons.help_outline,

                              label: "cvv"),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: defaultformfield(
                              controller: address,
                              type: TextInputType.text,
                              validation: (value) {
                                if (value!.isEmpty) {
                                  return " address  ";
                                }
                                return null;
                              },

                              Prefixicon: Icons.location_on_outlined,

                              label: "address"),
                        ),
                        SizedBox(height: 20),
                        loadingbutton(
                            inputstate: state is! orderloadingstate,
                            buttonname: "get order",
                            Function: (){
                              if(formkey.currentState!.validate()!){
                                PaymentCubit.get(context).order(
                                    cardnumber: cardnumber.text,
                                    cvv: cvv.text,
                                    address: address.text,
                                    expiredata: expiredate.text);
                              }

                            })


                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },


      ),
    );
  }
}