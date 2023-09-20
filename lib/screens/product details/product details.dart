import 'package:ecommerce/constats/componet.dart';
import 'package:ecommerce/screens/product%20details/cubit/productdetails_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product model/productmodel.dart';
import 'cubit/productdetails_cubit.dart';

class ProductDetailScreen extends StatelessWidget {
  final productmodel model;

  ProductDetailScreen({required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductdetailsCubit(),
      child: BlocConsumer<ProductdetailsCubit, ProductdetailsState>(
        listener: (context, state) {
          if (state is addtocart_success_state){
            showtoast(msg: "added to cart", color: Colors.green);

          }
          else if (state is addtocart_error_state){
            showtoast(msg: "server error", color: Colors.red);

          }

        },
        builder: (context, state) {
          var cubit = ProductdetailsCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text("Product Details"),

            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Image.network(
                      model.image!,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "product name: ${model.name}",
                      style: TextStyle(
                        fontSize: 18.0,
                        height: 1.3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Text(
                          "price: \$ ${model.price} ",
                          style: TextStyle(
                            fontSize: 14.0,
                            height: 1.3,
                          ),
                        ),
                        Spacer(),
                        Text(
                          (int.tryParse(model.stockQuantity!) ?? 0) != 0 ? "In Stock" : "Out of Stock",
                          style: TextStyle(
                              fontSize: 15.0,
                              height: 1.3,
                              color:(int.tryParse(model.stockQuantity!) ?? 0) != 0 ? Colors.green:Colors.red
                          ),
                        )


                      ],
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "${model.description} ",
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    loadingbutton(inputstate: state is! addtocart_loading_state , buttonname: "add to cart ",
                        Function: (){
                          cubit.addtocart(
                              name: model.name!,
                              category: model.category!,
                              price: model.price!,
                              stockQuantity:model. stockQuantity!,
                              description: model.description!,
                              image:model. image!,
                              id:model. id!

                          );


                        }


                        ),
                    SizedBox(height: 30.0),

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
