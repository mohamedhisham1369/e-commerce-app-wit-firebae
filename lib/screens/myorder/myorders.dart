// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:ecommerce/models/ordermodel/ordermodel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'cubit/myorder_cubit.dart';
// import 'cubit/myorder_state.dart';
//
// class myorder extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => MyorderCubit()..getOrders(),
//       child: BlocConsumer<MyorderCubit, MyorderState>(
//         listener: (BuildContext context, Object? state) {},
//         builder: (BuildContext context, state) {
//           var cubit=MyorderCubit.get(context);
//           return Scaffold(
//             appBar: AppBar(
//               title: Text("orderscreen"),
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: ConditionalBuilder(
//                 condition: state is! getdata_loading_state ,
//                 builder: (context) => Column(
//                   children: [
//                     Expanded(
//                       child: ListView.separated(
//                         itemBuilder: (BuildContext context, int index) =>
//                             buildGridProduct(context, cubit.orderList[index],index),
//                         separatorBuilder: (BuildContext context, int index) =>
//                             Divider(),
//                         itemCount: cubit.orderList.length,
//                       ),
//                     ),
//                   ],
//                 ),
//                 fallback: (context) => Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//             ),
//
//
//           );
//         },
//
//
//       ),
//     );
//   }
//   // Widget buildGridProduct(BuildContext context, OrderModel model,int index) {
//   //   return Container(
//   //     width: double.infinity,
//   //     child: Row(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //
//   //
//   //         Expanded(
//   //           child: Row(
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               Container(
//   //                 color: Colors.blue,
//   //                 child: Card(
//   //                   elevation: 0.1,
//   //                   color: Colors.blue,
//   //                   child: Image.network(
//   //                     model.productlist[index]['image'],
//   //                     width: 150,
//   //                   ),
//   //                 ),
//   //               ),
//   //               SizedBox(width: 20),
//   //               Column(
//   //                 children: [
//   //                   Text(
//   //                     model.productlist[index]['name'],
//   //                     style: TextStyle(
//   //                       color: Colors.blue,
//   //                       fontWeight: FontWeight.bold,
//   //                       fontSize: 15,
//   //                     ),
//   //                   ),
//   //                   SizedBox(width: 20),
//   //
//   //                   Text(
//   //                     model.productlist[index]['description'],
//   //                     maxLines: 2,
//   //                     overflow: TextOverflow.ellipsis,
//   //                     style: TextStyle(
//   //                       color: Colors.blue,
//   //                       fontWeight: FontWeight.bold,
//   //                       fontSize: 15,
//   //                     ),
//   //                   ),
//   //                   SizedBox(width: 20),
//   //
//   //                   Text(
//   //                     model.productlist[index]['price'],
//   //                     maxLines: 2,
//   //                     overflow: TextOverflow.ellipsis,
//   //                   ),
//   //                   SizedBox(width: 20),
//   //
//   //                 ],
//   //               ),
//   //
//   //             ],
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//   Widget buildGridProduct(BuildContext context, OrderModel model, int index) {
//     return Container(
//       width: double.infinity,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             color: Colors.blue,
//             child: Card(
//               elevation: 0.1,
//               color: Colors.blue,
//               child: Image.network(
//                 model.productlist[index]['image'],
//                 width: 150,
//               ),
//             ),
//           ),
//           SizedBox(width: 20),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   model.productlist[index]['name'],
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),
//                 SizedBox(height: 8), // Add some spacing
//                 Text(
//                   model.productlist[index]['description'],
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                   ),
//                 ),
//                 SizedBox(height: 8), // Add some spacing
//                 Text(
//                   "\$" + model.productlist[index]['price'],
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
// }
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/models/ordermodel/ordermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/myorder_cubit.dart';
import 'cubit/myorder_state.dart';

class myorder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MyorderCubit()..getOrders(),
      child: BlocConsumer<MyorderCubit, MyorderState>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          var cubit = MyorderCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("orderscreen"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ConditionalBuilder(
                condition: state is! getdata_loading_state,
                builder: (context) => Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) =>
                            buildGridProduct(context, cubit.orderList[index]),
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(),
                        itemCount: cubit.orderList.length,
                      ),
                    ),
                  ],
                ),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildGridProduct(BuildContext context, OrderModel model) {


    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, // Border color
              width: 2.0, // Border width
            ),
            borderRadius: BorderRadius.circular(10.0), // Border radius
          ),
          child: Column(
            children: [
              for (var product in model.productlist)
                Container(
                  padding: EdgeInsets.all(16.0), // Add padding around each product item
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.blue,
                        child: Card(
                          elevation: 0.1,
                          color: Colors.blue,
                          child: Image.network(
                            product['image'],
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
                              product['name'],
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 8), // Add some spacing
                            Text(
                              product['description'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 10),

      ],
    );
  }
}
