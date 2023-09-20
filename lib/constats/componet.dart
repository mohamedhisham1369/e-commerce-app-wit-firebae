import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultformfield({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?)? validation,
  required String label,
  IconData ? Prefixicon,
  bool ispassword =false,
  IconData? suffix,
  Function? suffixPressed,
  Function()? ontab,
  Function(String?)? onclick,
  bool isclickable=true,

})=>TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText:ispassword,
  validator: validation,
  enabled: isclickable,
  decoration: InputDecoration(
    labelText: label ,
    prefixIcon: Icon(
      Prefixicon,
    ),
    border: OutlineInputBorder(),
    suffixIcon: suffix != null
        ? IconButton(
      icon: Icon(suffix),
      onPressed: (){
        if (suffixPressed != null) {
          suffixPressed();
        }
      },
    )
        : null,
  ),
  onTap: ontab,
    onTapOutside:(event){
    FocusManager.instance.primaryFocus?.unfocus();

    },

);



Widget deaafulticonbutton({required Function , required String label,required var icon})=> Center(
  child: TextButton(onPressed: Function,
    child:Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon,color: Colors.black,size: 30, ),
          SizedBox(width: 10,),
          Text("${label}",style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),)



        ],


      ),
    ),
  ),
);





Widget button({
  required VoidCallback function,
  required String name,
}) => Container(
  width: double.infinity, // Make the button extend along the width of the page
  child: ElevatedButton(
    onPressed: function,
    style: ElevatedButton.styleFrom(
      primary: Colors.black, // Set the background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    child: Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
      child: Text(
        '${name}',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  ),
);

Widget lockicon ()=> Container(
  width: 200,
  height: 200,
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage("images/lock 1.png"),
      fit: BoxFit.fill,
    ),
  ),
);

Widget deafaulttext( {required String text})=>SizedBox(

  child: Text(
    '${text}',
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Lato',
      fontWeight: FontWeight.w400,

    ),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  ),
);


Widget appbartext({required String text})=>Text(
  '${text}',
  textAlign: TextAlign.center,
  style: TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontFamily: 'Lato',
    fontWeight: FontWeight.w700,
  ),
);



void naviagte(context,widget){
  Navigator.push(context, MaterialPageRoute(builder: (context) =>widget)  );

}

void naviagtefinsh(context,widget){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>widget) ,(route)=>false );

}

Widget loadingbutton( {required inputstate, required  buttonname, Function  })=>ConditionalBuilder(
  condition:  inputstate,
  builder: (context){
    return Container(
        child: button(function:Function, name: "${buttonname}"));
  },
  fallback: (context)=>Center(child: CircularProgressIndicator()),

);

void showtoast({required String msg,required var color})=> Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0
);

