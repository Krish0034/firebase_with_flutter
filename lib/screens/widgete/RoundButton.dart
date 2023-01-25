import 'package:flutter/material.dart';
import '../../utils/CustomsColors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const RoundButton({Key? key,required this.title,required this.onTap,this.loading=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 350,
        height: 50,
        decoration: BoxDecoration(
          color: CustomsColors.c3,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Center(
          child: loading? CircularProgressIndicator(strokeWidth: 3,color: CustomsColors.c6,) :Text(title,style:TextStyle(
            color: CustomsColors.c14,
            fontSize: 23,
            // fontWeight: FontWeight.bold,
            letterSpacing: 1.0
          ),),
        ),
      ),
    );
  }
}
