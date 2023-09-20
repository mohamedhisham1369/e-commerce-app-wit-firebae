import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/constats/componet.dart';
import 'package:ecommerce/models/product%20model/productmodel.dart';
import 'package:ecommerce/screens/cart/cubit/cart_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../payment method/payment.dart';
import '../product details/product details.dart';
import 'cubit/cart_cubit.dart';


class cartscreen extends StatelessWidget {
 static var totalmoney;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cartcubit()..getdata(),
      child: BlocConsumer<cartcubit, cartState>(
        listener: (BuildContext context, Object? state) {

          if (state is getcart_success_state) {
            totalmoney = state.value;
          }
        },
        builder: (BuildContext context, state) {
          var cubit = cartcubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("cartscreen"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ConditionalBuilder(
                condition: state is! getcart_loading_state ,
                builder: (context) => Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) =>
                            buildGridProduct(context, cubit.productlist[index]),
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(),
                        itemCount: cubit.productlist.length,
                      ),
                    ),
                  ],
                ),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            bottomNavigationBar: totalmoney == 0
                ? Center(
              child: Text(
                "You have no items in the cart",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            )
                : Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Total Price: ${totalmoney}",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10), // Add some space between the total price and the button
                  button(
                    function: () {
                      naviagte(context, payment());
                    },
                    name: "checkout",
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),

          );
        },
      ),
    );
  }


  Widget buildGridProduct(BuildContext context, productmodel model) {
    return Dismissible(
      key: UniqueKey(), // Unique key for each item
      onDismissed: (direction) {

        cartcubit.get(context).removeitem(model: model);


      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          naviagte(context, ProductDetailScreen(model: model));
        },
        child: Container(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.blue,
                child: Card(
                  elevation: 0.1,
                  color: Colors.blue,
                  child: Image.network(
                    model.image!,
                    width: 150,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      model.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "\$" + model.price!,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
