import 'package:firebase_with_flutter/utils/CustomsColors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ErrorHandler
{
 void toastMessage(String messs)
 {
   Fluttertoast.showToast
     (
       msg: messs,
       toastLength: Toast.LENGTH_SHORT,
       gravity: ToastGravity.BOTTOM,
       timeInSecForIosWeb: 120,
       backgroundColor: CustomsColors.c3,
       textColor: CustomsColors.c14,
       fontSize: 22.0
   );
 }
}