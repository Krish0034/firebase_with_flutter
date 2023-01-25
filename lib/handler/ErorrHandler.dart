import 'package:firebase_with_flutter/utils/CustomsColors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ErorrHandler
{
 void toastMessage(String messs)
 {
   Fluttertoast.showToast
     (
       msg: messs,
       toastLength: Toast.LENGTH_SHORT,
       gravity: ToastGravity.BOTTOM,
       timeInSecForIosWeb: 40,
       backgroundColor: CustomsColors.c3,
       textColor: CustomsColors.c14,
       fontSize: 22.0
   );
 }
}