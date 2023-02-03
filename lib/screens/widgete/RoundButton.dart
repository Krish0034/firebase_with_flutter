import 'package:flutter/material.dart';
import '../../utils/CustomsColors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  final Color color;
  const RoundButton({Key? key,required this.title,required this.onTap,this.loading=false,required this.color}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 350,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(
          child: loading? CircularProgressIndicator(strokeWidth: 3,color: CustomsColors.c6,) :Text(title,style:TextStyle(
            color: CustomsColors.c14,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0
          ),),
        ),
      ),
    );
  }
}
