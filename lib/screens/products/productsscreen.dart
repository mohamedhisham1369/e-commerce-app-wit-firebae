
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/screens/products/cubit/products_cubit.dart';
import 'package:ecommerce/screens/products/cubit/products_state.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constats/componet.dart';
import '../../models/product model/productmodel.dart';
import '../product details/product details.dart';

class productscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => productcubit()..getdata(),
      child: BlocConsumer<productcubit, product_screen_state>(
        listener: (context, state) {
          if(state is addtocart_success_home_state){
            showtoast(msg: "Added to cart", color: Colors.green);

          }
          else if(state is addtocart_error_home_state){
            showtoast(msg: "already in cart", color: Colors.red);

          }

        },
        builder: (context, state) {

          var cubit = productcubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("Home"),


            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ConditionalBuilder(
                condition: state is! product_loading_state,
                builder: (context) {
                  return Container(

                    child: GridView.builder(


                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1 / 1.9,
                      ),
                      itemCount: cubit.product.length,
                      itemBuilder: (context, index) =>
                          buildGridProduct(context, cubit.product[index]),
                    ),
                  );
                },
                fallback: (context) => Center(child: CircularProgressIndicator()),
              ),
            ),

          );
        },
      ),
    );
  }

  Widget buildGridProduct(BuildContext context, productmodel model) => GestureDetector(
    onTap: (){
      naviagte(context,  ProductDetailScreen(model: model),);
    },
    child: Card( // Using Card widget for product cards
      elevation: 3, // Add elevation for a card-like appearance
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide( // Add a border side with the desired color
          color: Colors.black, // Change this color to your desired color
          width: 2.0, // You can adjust the border width as needed
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  model.image ! ,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "${model.name}",
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
                  "${model.price}  \$ ",
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                IconButton(onPressed: (){
                  productcubit.get(context).addtocart(
                      name: model!.name!,
                      category:  model!.category!,
                      price:  model!.price!,
                      stockQuantity:  model!.stockQuantity!,
                      description:  model!.description!,
                      image:  model!.image!,
                      id: model!.id!,

                  );



                }, icon: Icon(Icons.add_shopping_cart))


              ],
            ),


          ],
        ),
      ),
    ),
  );
}
