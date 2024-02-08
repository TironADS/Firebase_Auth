import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
 void toastMessage(String messsage){
   Fluttertoast.showToast(
       msg: messsage,
       toastLength: Toast.LENGTH_SHORT,
       gravity: ToastGravity.BOTTOM,
       timeInSecForIosWeb: 2,
       backgroundColor: Colors.grey[200],
       textColor: Colors.grey[800],
       fontSize: 13.5
   );
 }

}